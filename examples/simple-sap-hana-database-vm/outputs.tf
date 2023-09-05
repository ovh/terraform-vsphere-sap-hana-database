output "sap_hana_databases_ids" {
  description = "Map of SAP HANA databases virtual machines names and its IDs"
  value       = module.sap-hana-database.sap_hana_databases_ids
}

output "affinity_hosts_sap_hana_databases_rules" {
  description = "Map of affinity hosts rules information"
  value       = module.sap-hana-database.affinity_hosts_sap_hana_databases_rules
}

output "anti_affinity_sap_hana_databases_rule" {
  description = "Map of anti affinity SAP HANA databases virtual machines rule information"
  value       = module.sap-hana-database.anti_affinity_sap_hana_databases_rule
}
