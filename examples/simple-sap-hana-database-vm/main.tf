provider "vsphere" {
  vsphere_server = "pcc-xx-xx-xx-xx.ovh.com"
}

module "sap-hana-database" {
  source = "../../"

  sap_hana_database_datastore              = "vsanDatastore"
  sap_hana_database_thin_datastore_policy  = "vSAN Default Storage Policy"
  sap_hana_database_thick_datastore_policy = "SAP HANA VM Storage Policy"
  sap_hana_databases = [
    {
      "name"                    = "terraform-vm-hana-1",
      "model"                   = "S",
      "cpus"                    = "",
      "cpus_per_socket"         = "24",
      "memory"                  = "",
      "custom_disks"            = false,
      "scsi_controller_count"   = "",
      "disks"                   = []
      "networks"                = ["VLAN20"],
      "guest_id"                = "sles15_64Guest",
      "vsphere_content_library" = "",
      "template"                = "",
      "iso_datastore"           = "",
      "iso_path"                = ""
      "vapp_options"            = {}
    }
  ]
  vsphere_compute_cluster = "Cluster1"
  vsphere_datacenter      = "pcc-xx-xx-xx-xx_datacenterxxxx"
}