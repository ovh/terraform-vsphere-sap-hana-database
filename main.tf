resource "vsphere_virtual_machine" "sap_hana_database" {
  for_each                   = { for sap_hana_database in var.sap_hana_databases : sap_hana_database.name => sap_hana_database }
  name                       = each.value.name
  resource_pool_id           = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id               = data.vsphere_datastore.datastore.id
  num_cpus                   = each.value.model == "" ? each.value.cpus : lookup(local.sap_hana_database_model_cpus, each.value.model)
  num_cores_per_socket       = each.value.cpus_per_socket
  memory                     = each.value.model == "" ? each.value.memory : lookup(local.sap_hana_database_model_memory, each.value.model)
  memory_reservation         = each.value.model == "" ? each.value.memory : lookup(local.sap_hana_database_model_memory, each.value.model)
  folder                     = var.sap_hana_database_folder
  guest_id                   = each.value.guest_id
  hardware_version           = var.sap_hana_database_hardware_version
  wait_for_guest_net_timeout = var.sap_hana_database_wait_for_guest_net_timeout
  wait_for_guest_ip_timeout  = var.sap_hana_database_wait_for_guest_ip_timeout
  scsi_controller_count      = each.value.custom_disks == false ? 4 : each.value.scsi_controller_count
  dynamic "disk" {
    for_each = each.value.custom_disks == true ? each.value.disks : [
      { "id" : 0, "label" : "disk0", "size" : "128", "thin_provisioned" : true, "eagerly_scrub" : false, "datastore_name" : var.sap_hana_database_datastore, "datastore_policy" : var.sap_hana_database_thin_datastore_policy },
      { "id" : 1, "label" : "disk1", "size" : "32", "thin_provisioned" : true, "eagerly_scrub" : false, "datastore_name" : var.sap_hana_database_datastore, "datastore_policy" : var.sap_hana_database_thin_datastore_policy },
      { "id" : 15, "label" : "disk2", "size" : each.value.model == "" ? each.value.memory / 1024 : lookup(local.sap_hana_database_model_memory, each.value.model) / 1024, "thin_provisioned" : false, "eagerly_scrub" : true, "datastore_name" : var.sap_hana_database_datastore, "datastore_policy" : var.sap_hana_database_thick_datastore_policy },
      { "id" : 30, "label" : "disk3", "size" : each.value.model == "" ? each.value.memory < 524288 ? each.value.memory / 2048 : 512 : lookup(local.sap_hana_database_model_log_disk, each.value.model), "thin_provisioned" : false, "eagerly_scrub" : true, "datastore_name" : var.sap_hana_database_datastore, "datastore_policy" : var.sap_hana_database_thick_datastore_policy },
      { "id" : 2, "label" : "disk4", "size" : each.value.model == "" ? each.value.memory < 1048576 ? each.value.memory / 1024 : 1024 : lookup(local.sap_hana_database_model_memory, each.value.model) < 1048576 ? lookup(local.sap_hana_database_model_memory, each.value.model) / 1024 : 1024, "thin_provisioned" : false, "eagerly_scrub" : true, "datastore_name" : var.sap_hana_database_datastore, "datastore_policy" : var.sap_hana_database_thick_datastore_policy },
      { "id" : 45, "label" : "disk5", "size" : each.value.model == "" ? each.value.memory < 524288 ? each.value.memory / 1024 + each.value.memory / 2048 : each.value.memory / 1024 + 512 : lookup(local.sap_hana_database_model_memory, each.value.model) / 1024 + lookup(local.sap_hana_database_model_log_disk, each.value.model), "thin_provisioned" : true, "eagerly_scrub" : false, "datastore_name" : var.sap_hana_database_datastore, "datastore_policy" : var.sap_hana_database_thin_datastore_policy },
    ]
    content {
      label             = disk.value.label
      size              = disk.value.size
      unit_number       = disk.value.id
      thin_provisioned  = disk.value.thin_provisioned
      eagerly_scrub     = disk.value.eagerly_scrub
      datastore_id      = each.value.custom_disks == true ? data.vsphere_datastore.custom_datastore_disks[disk.value.datastore_name].id : data.vsphere_datastore.default_datastore_disks[disk.value.label].id
      storage_policy_id = disk.value.datastore_policy == "" ? "" : each.value.custom_disks == true ? data.vsphere_storage_policy.custom_datastore_disks[disk.value.datastore_policy].id : data.vsphere_storage_policy.default_datastore_disks[disk.value.label].id
    }
  }
  dynamic "network_interface" {
    for_each = each.value.networks

    content {
      network_id = data.vsphere_network.network[network_interface.value].id
    }
  }
  dynamic "cdrom" {
    for_each = compact([each.value.iso_datastore])

    content {
      datastore_id = data.vsphere_datastore.iso_datastore[cdrom.value].id
      path         = each.value.iso_path
    }
  }
  dynamic "clone" {
    for_each = compact([each.value.template])
    content {
      template_uuid = data.vsphere_content_library_item.item[each.value.name].id
    }
  }
  dynamic "vapp" {
    for_each = [{ for k, v in each.value.vapp_options : k => v }]
    content {
      properties = vapp.value
    }
  }

  lifecycle {
    ignore_changes = [
      vapp[0].properties,
      clone[0].template_uuid
    ]
  }
}

resource "vsphere_compute_cluster_vm_anti_affinity_rule" "sap_hana_database_anti_affinity_rule" {
  count               = var.sap_hana_database_anti_affinity_rule_enable == true ? 1 : 0
  name                = var.sap_hana_database_anti_affinity_rule_name
  compute_cluster_id  = data.vsphere_compute_cluster.cluster.id
  virtual_machine_ids = [for v in vsphere_virtual_machine.sap_hana_database : v.id]
  mandatory           = var.sap_hana_database_anti_affinity_rule_mandatory
}

resource "vsphere_compute_cluster_vm_group" "cluster_sap_hana_database_group" {
  for_each            = { for group in var.sap_hana_database_hosts_distribution : group.group_name => group }
  name                = "sap-hana-databases-group-${each.value.group_name}"
  compute_cluster_id  = data.vsphere_compute_cluster.cluster.id
  virtual_machine_ids = [for vm in each.value.sap_hana_databases : vsphere_virtual_machine.sap_hana_database[vm].id]
}

resource "vsphere_compute_cluster_host_group" "cluster_host_group" {
  for_each           = { for group in var.sap_hana_database_hosts_distribution : group.group_name => group }
  name               = "hosts-group-${each.value.group_name}"
  compute_cluster_id = data.vsphere_compute_cluster.cluster.id
  host_system_ids    = [for host in each.value.hosts : data.vsphere_host.host[host].id]
}

resource "vsphere_compute_cluster_vm_host_rule" "cluster_vm_host_rule" {
  for_each                 = { for group, info in var.sap_hana_database_hosts_distribution : group => info }
  compute_cluster_id       = data.vsphere_compute_cluster.cluster.id
  name                     = "affinity-sap-hana-databases-host-rule-${each.value.group_name}"
  vm_group_name            = vsphere_compute_cluster_vm_group.cluster_sap_hana_database_group[each.value.group_name].name
  affinity_host_group_name = vsphere_compute_cluster_host_group.cluster_host_group[each.value.group_name].name
  mandatory                = each.value.mandatory
}
