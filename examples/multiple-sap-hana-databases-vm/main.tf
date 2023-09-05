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
      "model"                   = "M",
      "cpus"                    = "",
      "cpus_per_socket"         = "48",
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
    },
    {
      "name"                  = "terraform-vm-hana-2",
      "model"                 = "S",
      "cpus"                  = "",
      "cpus_per_socket"       = "24",
      "memory"                = "",
      "custom_disks"          = true,
      "scsi_controller_count" = "4",
      "disks" = [
        { "id" : 0, "label" : "disk0", "size" : "128", "thin_provisioned" : true, "eagerly_scrub" : false, "datastore_name" : "vsanDatastore", "datastore_policy" : "vSAN Default Storage Policy" },
        { "id" : 1, "label" : "disk1", "size" : "32", "thin_provisioned" : true, "eagerly_scrub" : false, "datastore_name" : "vsanDatastore", "datastore_policy" : "vSAN Default Storage Policy" },
        { "id" : 15, "label" : "disk2", "size" : "384", "thin_provisioned" : false, "eagerly_scrub" : true, "datastore_name" : "vsanDatastore", "datastore_policy" : "SAP HANA VM Storage Policy" },
        { "id" : 30, "label" : "disk3", "size" : "192", "thin_provisioned" : false, "eagerly_scrub" : true, "datastore_name" : "vsanDatastore", "datastore_policy" : "SAP HANA VM Storage Policy" },
        { "id" : 2, "label" : "disk4", "size" : "384", "thin_provisioned" : false, "eagerly_scrub" : true, "datastore_name" : "vsanDatastore", "datastore_policy" : "SAP HANA VM Storage Policy" },
        { "id" : 45, "label" : "disk5", "size" : "576", "thin_provisioned" : true, "eagerly_scrub" : false, "datastore_name" : "vsanDatastore", "datastore_policy" : "vSAN Default Storage Policy" },
      ]
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
