variable "vsphere_datacenter" {
  type        = string
  description = "Name of the datacenter in vSphere interface"
}

variable "sap_hana_database_datastore" {
  type        = string
  description = "Name of the datastore to store SAP HANA databases virtual machines"
}

variable "vsphere_compute_cluster" {
  type        = string
  description = <<EOH
  Name of the vSphere cluster
  Example: Cluster1
  EOH
}

variable "sap_hana_databases" {
  type        = list(any)
  description = <<EOH
  List of SAP HANA databases virtual machines wanted with these parameters (mandatory, even if empty).

  Example
  [
    {
      "name"                    = "hana1",
      "model"                   = "M",
      "cpus"                    = "",
      "cpus_per_socket"         = "48",
      "memory"                  = "",
      "custom_disks"            = false,
      "scsi_controller_count"   = "",
      "disks"                   = [],
      "networks"                = ["VLAN20"],
      "guest_id"                = "sles15_64Guest",
      "vsphere_content_library" = "",
      "template"                = "",
      "iso_datastore"           = "",
      "iso_path"                = "",
      "vapp_options"            = {}
    },
    {
      "name"                    = "hana2",
      "model"                   = "S",
      "cpus"                    = "",
      "cpus_per_socket"         = "24",
      "memory"                  = "",
      "custom_disks"            = false,
      "scsi_controller_count"   = "",
      "disks"                   = [],
      "networks"                = ["VLAN20"],
      "guest_id"                = "sles15_64Guest",
      "vsphere_content_library" = "",
      "template"                = "",
      "iso_datastore"           = "",
      "iso_path"                = "",
      "vapp_options"            = {}
    }
  ]
  EOH
}

variable "sap_hana_database_folder" {
  type        = string
  default     = ""
  description = "Name of the folder to store the SAP HANA database virtual machines"
}

variable "sap_hana_database_anti_affinity_rule_enable" {
  type        = bool
  default     = false
  description = "Avoid running SAP HANA databases virtual machines on the same ESXi host"
}

variable "sap_hana_database_anti_affinity_rule_name" {
  type        = string
  default     = "sap-hana-database-anti-affinity-rule"
  description = "Name for the anti-affinity rule"
}

variable "sap_hana_database_anti_affinity_rule_mandatory" {
  type        = bool
  default     = false
  description = "When this value is true, prevents any virtual machine operations that may violate this rule"
}

variable "sap_hana_database_hardware_version" {
  type        = number
  default     = 19
  description = <<EOH
  Hardware compatibility between SAP HANA database virtual machine and ESXi host. By default, the newest version.
  More information available on [VMware](https://kb.vmware.com/s/article/2007240)
  EOH
}

variable "sap_hana_database_wait_for_guest_net_timeout" {
  type        = number
  default     = 0
  description = "The amount of time, in minutes, to wait for an available guest IP address on the SAP HANA database virtual machine."
}

variable "sap_hana_database_wait_for_guest_ip_timeout" {
  type        = number
  default     = 0
  description = "The amount of time, in minutes, to wait for an available guest IP address on the SAP HANA database virtual machine."
}

variable "sap_hana_database_hosts_distribution" {
  type        = list(any)
  default     = []
  description = <<EOH
  Allow to set which SAP HANA database virtual machines have to run on a specific ESXi host.
  When mandatory is true, prevents any virtual machine operations that may violate this rule.
  
  Example:
  [
    {
      "group_name" = "hana-primary",
      "hosts" = ["192.168.2.1", "192.168.2.2"],
      "sap_hana_databases" = ["hana1"],
      "mandatory" = true
    },
    {
      "group_name" = "hana-secondary",
      "hosts" = ["192.168.2.2", "192.168.2.3"],
      "sap_hana_databases" = ["hana2"],
      "mandatory" = false
    }
  ]
  EOH
}

variable "sap_hana_database_thick_datastore_policy" {
  type        = string
  default     = ""
  description = "This Storage Policy must be a Thick provisioning"
}

variable "sap_hana_database_thin_datastore_policy" {
  type        = string
  default     = ""
  description = "This Storage Policy must be a Thin provisioning"
}
