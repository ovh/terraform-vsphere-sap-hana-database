locals {
  sap_hana_database_model_cpus = {
    S = 24,
    M = 48,
    L = 96
  }

  sap_hana_database_model_memory = {
    S = 393216,
    M = 786432,
    L = 1436000
  }

  sap_hana_database_model_log_disk = {
    S = 192,
    M = 384,
    L = 512
  }

  sap_hana_database_default_disks = [
    { "label" : "disk0", "datastore_name" : var.sap_hana_database_datastore, "datastore_policy" : var.sap_hana_database_thin_datastore_policy },
    { "label" : "disk1", "datastore_name" : var.sap_hana_database_datastore, "datastore_policy" : var.sap_hana_database_thin_datastore_policy },
    { "label" : "disk2", "datastore_name" : var.sap_hana_database_datastore, "datastore_policy" : var.sap_hana_database_thick_datastore_policy },
    { "label" : "disk3", "datastore_name" : var.sap_hana_database_datastore, "datastore_policy" : var.sap_hana_database_thick_datastore_policy },
    { "label" : "disk4", "datastore_name" : var.sap_hana_database_datastore, "datastore_policy" : var.sap_hana_database_thick_datastore_policy },
    { "label" : "disk5", "datastore_name" : var.sap_hana_database_datastore, "datastore_policy" : var.sap_hana_database_thin_datastore_policy }
  ]

  disks_per_vm = flatten([
    for disk_label in { for sap_hana_database in var.sap_hana_databases : sap_hana_database.name => sap_hana_database.disks[*].datastore_name } : disk_label
  ])

  storage_policy_per_disks = flatten([
    for storage_policy in { for sap_hana_database in var.sap_hana_databases : sap_hana_database.name => sap_hana_database.disks[*].datastore_policy } : storage_policy
  ])

  network_cards_per_vm = flatten([
    for network_cards in { for sap_hana_database in var.sap_hana_databases : sap_hana_database.name => sap_hana_database.networks } : network_cards
  ])

  template_per_vm = { for sap_hana_database in var.sap_hana_databases : sap_hana_database.name => sap_hana_database.template if sap_hana_database.template != "" }

  content_library_per_vm = { for sap_hana_database in var.sap_hana_databases : sap_hana_database.name => sap_hana_database.vsphere_content_library if sap_hana_database.vsphere_content_library != "" }

  iso_datastore_per_vm = flatten([
    for iso_datastore in { for sap_hana_database in var.sap_hana_databases : sap_hana_database.name => sap_hana_database.iso_datastore } : iso_datastore
  ])

  hosts_distribution_per_vm = flatten([
    for hosts_distribution in { for group in var.sap_hana_database_hosts_distribution : group.group_name => group.hosts } : hosts_distribution
  ])
}
