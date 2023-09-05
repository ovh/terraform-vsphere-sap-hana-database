data "vsphere_datacenter" "datacenter" {
  name = var.vsphere_datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.sap_hana_database_datastore
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_datastore" "custom_datastore_disks" {
  for_each      = toset(compact(local.disks_per_vm))
  name          = each.value
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_datastore" "default_datastore_disks" {
  for_each      = { for k in local.sap_hana_database_default_disks : k.label => k.datastore_name }
  name          = each.value
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_storage_policy" "custom_datastore_disks" {
  for_each = toset(compact(local.storage_policy_per_disks))
  name     = each.value
}

data "vsphere_storage_policy" "default_datastore_disks" {
  for_each = { for k in local.sap_hana_database_default_disks : k.label => k.datastore_policy if k.datastore_policy != "" }
  name     = each.value
}

data "vsphere_datastore" "iso_datastore" {
  for_each      = toset(compact(local.iso_datastore_per_vm))
  name          = each.value
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere_compute_cluster
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network" {
  for_each      = toset(compact(local.network_cards_per_vm))
  name          = each.value
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_host" "host" {
  for_each      = toset(compact(local.hosts_distribution_per_vm))
  name          = each.value
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_content_library" "library" {
  for_each = local.content_library_per_vm
  name     = each.value
}

data "vsphere_content_library_item" "item" {
  for_each   = local.template_per_vm
  name       = each.value
  type       = "ova"
  library_id = data.vsphere_content_library.library[each.key].id
}
