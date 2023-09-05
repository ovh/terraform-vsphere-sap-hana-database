<!-- BEGIN_TF_DOCS -->
# Multiple SAP HANA databases VM

Usage of the module to deploy two SAP HANA databases virtual machines with different size (cost-optimize)

## vSphere user requirements

User in the vSphere client with the following permissions:
- vSphere access: Read/Write
- Access to the VM Network: Operator
- Access to the V(X)LANs: Operator

## Usage
Replace the value of variables by your values :
- sap\_hana\_database\_datastore
- sap\_hana\_database\_thin\_datastore\_policy
- sap\_hana\_database\_thick\_datastore\_policy
- vsphere\_compute\_cluster
- vsphere\_datacenter
- vsphere\_server

```bash
terraform init
terraform plan
terraform apply
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.5 |
| <a name="requirement_vsphere"></a> [vsphere](#requirement_vsphere) | >= 2.4.1 |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_affinity_hosts_sap_hana_databases_rules"></a> [affinity_hosts_sap_hana_databases_rules](#output_affinity_hosts_sap_hana_databases_rules) | Map of affinity hosts rules information |
| <a name="output_anti_affinity_sap_hana_databases_rule"></a> [anti_affinity_sap_hana_databases_rule](#output_anti_affinity_sap_hana_databases_rule) | Map of anti affinity SAP HANA databases virtual machines rule information |
| <a name="output_sap_hana_databases_ids"></a> [sap_hana_databases_ids](#output_sap_hana_databases_ids) | Map of SAP HANA databases virtual machines names and its IDs |
<!-- END_TF_DOCS -->