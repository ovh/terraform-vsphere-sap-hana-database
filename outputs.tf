output "sap_hana_databases_ids" {
  description = "Map of SAP HANA databases virtual machines names and its IDs"
  value       = { for sap_hana_database in vsphere_virtual_machine.sap_hana_database : sap_hana_database.name => sap_hana_database.id }
}

output "affinity_hosts_sap_hana_databases_rules" {
  description = "Map of affinity hosts SAP HANA databases virtual machines rules information"
  value = { for anti_affinity_rule in vsphere_compute_cluster_vm_host_rule.cluster_vm_host_rule : anti_affinity_rule.name => {
    "sap_hana_databases_group_name" = anti_affinity_rule.vm_group_name
    "affinity_host_group_name"      = anti_affinity_rule.affinity_host_group_name
    "sap_hana_databases_ids"        = [for sap_hana_database in vsphere_compute_cluster_vm_group.cluster_sap_hana_database_group : sap_hana_database.virtual_machine_ids if sap_hana_database.name == anti_affinity_rule.vm_group_name]
    }
  }
}

output "anti_affinity_sap_hana_databases_rule" {
  description = "Map of anti affinity SAP HANA databases virtual machines rule information"
  value = { for anti_affinity_rule in vsphere_compute_cluster_vm_anti_affinity_rule.sap_hana_database_anti_affinity_rule : anti_affinity_rule.name => {
    "name"                   = anti_affinity_rule.name
    "enable"                 = anti_affinity_rule.enabled
    "mandatory"              = anti_affinity_rule.mandatory
    "sap_hana_databases_ids" = anti_affinity_rule.virtual_machine_ids
    }
  }
}
