<!-- BEGIN_TF_DOCS -->
# OVHcloud SAP HANA databases Terraform module

Terraform module to create a set of SAP HANA databases virtual machines on VMware on OVHcloud.
You have the possibility to create many SAP HANA databases virtual machines with different parameters.

## vSphere user requirements

User in the vSphere client with the following permissions:
- vSphere access: Read/Write
- Access to the VM Network: Operator
- Access to the V(X)LANs: Operator

## How to use this module

This repository has an example folder which includes several ways to use this module.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.5 |
| <a name="requirement_vsphere"></a> [vsphere](#requirement_vsphere) | >= 2.4.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vsphere"></a> [vsphere](#provider_vsphere) | 2.4.1 |

## Resources

| Name | Type |
|------|------|
| [vsphere_compute_cluster_host_group.cluster_host_group](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/resources/compute_cluster_host_group) | resource |
| [vsphere_compute_cluster_vm_anti_affinity_rule.sap_hana_database_anti_affinity_rule](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/resources/compute_cluster_vm_anti_affinity_rule) | resource |
| [vsphere_compute_cluster_vm_group.cluster_sap_hana_database_group](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/resources/compute_cluster_vm_group) | resource |
| [vsphere_compute_cluster_vm_host_rule.cluster_vm_host_rule](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/resources/compute_cluster_vm_host_rule) | resource |
| [vsphere_virtual_machine.sap_hana_database](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/resources/virtual_machine) | resource |
| [vsphere_compute_cluster.cluster](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/compute_cluster) | data source |
| [vsphere_content_library.library](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/content_library) | data source |
| [vsphere_content_library_item.item](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/content_library_item) | data source |
| [vsphere_datacenter.datacenter](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/datacenter) | data source |
| [vsphere_datastore.custom_datastore_disks](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/datastore) | data source |
| [vsphere_datastore.datastore](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/datastore) | data source |
| [vsphere_datastore.default_datastore_disks](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/datastore) | data source |
| [vsphere_datastore.iso_datastore](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/datastore) | data source |
| [vsphere_host.host](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/host) | data source |
| [vsphere_network.network](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/network) | data source |
| [vsphere_storage_policy.custom_datastore_disks](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/storage_policy) | data source |
| [vsphere_storage_policy.default_datastore_disks](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/storage_policy) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_sap_hana_database_datastore"></a> [sap_hana_database_datastore](#input_sap_hana_database_datastore) | Name of the datastore to store SAP HANA databases virtual machines | `string` | n/a | yes |
| <a name="input_sap_hana_databases"></a> [sap_hana_databases](#input_sap_hana_databases) | List of SAP HANA databases virtual machines wanted with these parameters (mandatory, even if empty).<br><br>  Example<br>  [<br>    &emsp;{<br>&emsp;&emsp;      "name"                    = "hana1",<br>&emsp;&emsp;      "model"                   = "M",<br>&emsp;&emsp;      "cpus"                    = "",<br>&emsp;&emsp;      "cpus_per_socket"         = "48",<br>&emsp;&emsp;      "memory"                  = "",<br>&emsp;&emsp;      "custom_disks"            = false,<br>&emsp;&emsp;      "scsi_controller_count"   = "",<br>&emsp;&emsp;      "disks"                   = [],<br>&emsp;&emsp;      "networks"                = ["VLAN20"],<br>&emsp;&emsp;      "guest_id"                = "sles15_64Guest",<br>&emsp;&emsp;      "vsphere_content_library" = "",<br>&emsp;&emsp;      "template"                = "",<br>&emsp;&emsp;      "iso_datastore"           = "",<br>&emsp;&emsp;      "iso_path"                = "",<br>&emsp;&emsp;      "vapp_options"            = {}<br>    &emsp;},<br>&emsp;{<br>&emsp;&emsp;      "name"                    = "hana2",<br>&emsp;&emsp;      "model"                   = "S",<br>&emsp;&emsp;      "cpus"                    = "",<br>&emsp;&emsp;      "cpus_per_socket"         = "24",<br>&emsp;&emsp;      "memory"                  = "",<br>&emsp;&emsp;      "custom_disks"            = false,<br>&emsp;&emsp;      "scsi_controller_count"   = "",<br>&emsp;&emsp;      "disks"                   = [],<br>&emsp;&emsp;      "networks"                = ["VLAN20"],<br>&emsp;&emsp;      "guest_id"                = "sles15_64Guest",<br>&emsp;&emsp;      "vsphere_content_library" = "",<br>&emsp;&emsp;      "template"                = "",<br>&emsp;&emsp;      "iso_datastore"           = "",<br>&emsp;&emsp;      "iso_path"                = "",<br>&emsp;&emsp;      "vapp_options"            = {}<br>   &emsp;}<br>  ] | `list(any)` | n/a | yes |
| <a name="input_vsphere_compute_cluster"></a> [vsphere_compute_cluster](#input_vsphere_compute_cluster) | Name of the vSphere cluster<br>  Example: Cluster1 | `string` | n/a | yes |
| <a name="input_vsphere_datacenter"></a> [vsphere_datacenter](#input_vsphere_datacenter) | Name of the datacenter in vSphere interface | `string` | n/a | yes |
| <a name="input_sap_hana_database_anti_affinity_rule_enable"></a> [sap_hana_database_anti_affinity_rule_enable](#input_sap_hana_database_anti_affinity_rule_enable) | Avoid running SAP HANA databases virtual machines on the same ESXi host | `bool` | `false` | no |
| <a name="input_sap_hana_database_anti_affinity_rule_mandatory"></a> [sap_hana_database_anti_affinity_rule_mandatory](#input_sap_hana_database_anti_affinity_rule_mandatory) | When this value is true, prevents any virtual machine operations that may violate this rule | `bool` | `false` | no |
| <a name="input_sap_hana_database_anti_affinity_rule_name"></a> [sap_hana_database_anti_affinity_rule_name](#input_sap_hana_database_anti_affinity_rule_name) | Name for the anti-affinity rule | `string` | `"sap-hana-database-anti-affinity-rule"` | no |
| <a name="input_sap_hana_database_folder"></a> [sap_hana_database_folder](#input_sap_hana_database_folder) | Name of the folder to store the SAP HANA database virtual machines | `string` | `""` | no |
| <a name="input_sap_hana_database_hardware_version"></a> [sap_hana_database_hardware_version](#input_sap_hana_database_hardware_version) | Hardware compatibility between SAP HANA database virtual machine and ESXi host. By default, the newest version.<br>  More information available on [VMware](https://kb.vmware.com/s/article/2007240) | `number` | `19` | no |
| <a name="input_sap_hana_database_hosts_distribution"></a> [sap_hana_database_hosts_distribution](#input_sap_hana_database_hosts_distribution) | Allow to set which SAP HANA database virtual machines have to run on a specific ESXi host.<br>  When mandatory is true, prevents any virtual machine operations that may violate this rule.<br><br>  Example:<br>  [<br>    &emsp;{<br>&emsp;&emsp;      "group_name" = "hana-primary",<br>&emsp;&emsp;      "hosts" = ["192.168.2.1", "192.168.2.2"],<br>&emsp;&emsp;      "sap_hana_databases" = ["hana1"],<br>&emsp;&emsp;      "mandatory" = true<br>    &emsp;},<br>&emsp;{<br>&emsp;&emsp;      "group_name" = "hana-secondary",<br>&emsp;&emsp;      "hosts" = ["192.168.2.2", "192.168.2.3"],<br>&emsp;&emsp;      "sap_hana_databases" = ["hana2"],<br>&emsp;&emsp;      "mandatory" = false<br>   &emsp;}<br>  ] | `list(any)` | `[]` | no |
| <a name="input_sap_hana_database_thick_datastore_policy"></a> [sap_hana_database_thick_datastore_policy](#input_sap_hana_database_thick_datastore_policy) | This Storage Policy must be a Thick provisioning | `string` | `""` | no |
| <a name="input_sap_hana_database_thin_datastore_policy"></a> [sap_hana_database_thin_datastore_policy](#input_sap_hana_database_thin_datastore_policy) | This Storage Policy must be a Thin provisioning | `string` | `""` | no |
| <a name="input_sap_hana_database_wait_for_guest_ip_timeout"></a> [sap_hana_database_wait_for_guest_ip_timeout](#input_sap_hana_database_wait_for_guest_ip_timeout) | The amount of time, in minutes, to wait for an available guest IP address on the SAP HANA database virtual machine. | `number` | `0` | no |
| <a name="input_sap_hana_database_wait_for_guest_net_timeout"></a> [sap_hana_database_wait_for_guest_net_timeout](#input_sap_hana_database_wait_for_guest_net_timeout) | The amount of time, in minutes, to wait for an available guest IP address on the SAP HANA database virtual machine. | `number` | `0` | no |

As the variable `sap_hana_databases` is a list with many parameters, we present you one by one each parameter.

<table>
<thead>
  <tr>
    <th>Name</th>
    <th>Description</th>
    <th>Type</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>name</td>
    <td>Name of the virtual machine.</td>
    <td>string</td>
  </tr>
  <tr>
    <td>model</td>
    <td>The module proposes 3 models:<br>
        - S: 24vCPU and 384GB of memory<br>
        - M: 48vCPU and 768GB of memory<br>
        - L: 96vCPU and 1436GB of memory<br>
    </td>
    <td>string</td>
  </tr>
  <tr>
    <td>cpus</td>
    <td>Number of vCPU for the virtual machine.<br>
        <b>Mandatory if the variable model is empty.</b>
    </td>
    <td>string</td>
  </tr>
  <tr>
    <td>cpus_per_socket</td>
    <td>Number of vCPU per socket for the virtual machine.<br>
        <b>Mandatory even if the variable model is empty.</b>
    </td>
    <td>string</td>
  </tr>
  <tr>
    <td>memory</td>
    <td>Number of memory (in MB) for the virtual machine.<br>
        <b>Mandatory if the variable model is empty.</b>
    </td>
    <td>string</td>
  </tr>
  <tr>
    <td>custom_disks</td>
    <td>The module proposes by default six disks:<br>
        &emsp;- disk0 (root) | 128 GB | Thin provisioning<br>
        &emsp;- disk1 (sap) | 32 GB | Thin provisioning<br>
        &emsp;- disk2 (hana-data) | {memory_size} GB | Thick provisioning<br>
        &emsp;- disk3 (hana-log) | {memory_size < 512 ? 1/2 memory_size : 512} GB | Thick provisioning<br>
        &emsp;- disk4 (hana-shared) | {memory_size < 1024 ? memory_size : 1024} GB | Thick provisioning<br>
        &emsp;- disk5 (hana-backup) | {hana-data + hana-log} GB | Thin provisioning<br><br>
        If you want to set your own configuration for disks, set the variable to true.
    </td>
    <td>boolean</td>
  </tr>
  <tr>
    <td>scsi_controller_count</td>
    <td>Number of SCSI controller.<br>
        <b>Mandatory if the variable custom_disks is true.</b><br><br>
        VMware and SAP recommends to separate hanadata, hanalog and hanabackup on three different SCSI controllers.<br>
    </td>
    <td>number</td>
  </tr>
  <tr>
    <td>disks</td>
    <td>List of disks wanted if the variable custom_disks has been set to true.<br>
        <b>The default disk are no longer created if the variable custom_disks has been set to true</b><br><br>
        The structure has to be like this:<br>
        [<br>
        &emsp;{ "id" : 0, "label" : "disk0", "size" : "{size in GB}", "thin_provisioned" : {true | false=thick}, "eagerly_scrub": {true (only for thick) | false}, "datastore_name" : "{datastore to store disk}", "datastore_policy" : "{datastore policy}" },<br>&emsp;
        { "id" : 1, "label" : "disk1", "size" : "{size in GB}", "thin_provisioned" : {true | false=thick}, "eagerly_scrub": {true (only for thick) | false}, "datastore_name" : "{datastore to store disk}", "datastore_policy" : "{datastore policy}" },<br>&emsp;
        { "id" : 2, "label" : "disk2", "size" : "{size in GB}", "thin_provisioned" : {true | false=thick}, "eagerly_scrub": {true (only for thick) | false}, "datastore_name" : "{datastore to store disk}", "datastore_policy" : "{datastore policy}" },<br>&emsp;
        ...<br>
        ]<br><br>
        Each SCSI controller has 16 ID, if you want to use the second controller for your second disk, the id must be 15, for the third controller, the id must be 30, etc.<br><br>
        Caution, the datastore policy has to be set with the same behaviour on the thin or thick provisioning. Don't set a thin provisioning in the variable if the datastore policy set a thick provisioning.<br><br>
        You have also the possibility to let the datastore_policy empty (""), the Storage Policy by default for the datastore will be applied.<br><br>
        To know more about the Storage Policy (datastore_policy), please refer to the <a href="https://docs.vmware.com/en/VMware-vSphere/6.7/com.vmware.vsphere.storage.doc/GUID-89091D59-D844-46B2-94C2-35A3961D23E7.html">official documentation</a> on VMware.
    </td>
    <td>list()</td>
  </tr>
  <tr>
    <td>networks</td>
    <td>List of network cards.</td>
    <td>list()</td>
  </tr>
  <tr>
    <td>guest_id</td>
    <td>Operating System to be compatible between ESXi host and the virtual machine.<br>
        To know the possible value for this variable, please refer to the <a href="https://vdc-repo.vmware.com/vmwb-repository/dcr-public/da47f910-60ac-438b-8b9b-6122f4d14524/16b7274a-bf8b-4b4c-a05e-746f2aa93c8c/doc/vim.vm.GuestOsDescriptor.GuestOsIdentifier.html">official list</a> on VMware.
    </td>
    <td>string</td>
  </tr>
  <tr>
    <td>vsphere_content_library</td>
    <td>The Content Library name where the OVA is stored, if you want to create the virtual machine from a template.</td>
    <td>string</td>
  </tr>
  <tr>
    <td>template</td>
    <td>Name of the template.<br>
        <b>Mandatory if the variable vsphere_content_library has been set.</b>
    </td>
    <td>string</td>
  </tr>
  <tr>
    <td>iso_datastore</td>
    <td>Datastore name where the ISO file is stored, if you want to add a CD-ROM device and start the virtual machine on it.</td>
    <td>string</td>
  </tr>
  <tr>
    <td>iso_path</td>
    <td>Path in the datastore to locate the ISO file.<br>
        <b>Mandatory if the variable iso_datastore is not empty.</b>
    </td>
    <td>string</td>
  </tr>
  <tr>
    <td>vapp_options</td>
    <td>Map that you want to pass to the virtual machine.<br>
        <b>Only available with template which has vApp Options enabled.</b><br><br>
        Example: <br>
        &emsp;{<br>&emsp;&emsp;
            "guestinfo.hostname" : "vm-sap-hana",<br>&emsp;&emsp;
            "guestinfo.user" : "my-user",<br>&emsp;&emsp;
            "guestinfo.password" : "123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ",<br>&emsp;&emsp;
            "guestinfo.password_crypted" : "False"<br>
       &emsp;}<br>
    </td>
    <td>map</td>
  </tr>
</tbody>
</table>

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_affinity_hosts_sap_hana_databases_rules"></a> [affinity_hosts_sap_hana_databases_rules](#output_affinity_hosts_sap_hana_databases_rules) | Map of affinity hosts SAP HANA databases virtual machines rules information |
| <a name="output_anti_affinity_sap_hana_databases_rule"></a> [anti_affinity_sap_hana_databases_rule](#output_anti_affinity_sap_hana_databases_rule) | Map of anti affinity SAP HANA databases virtual machines rule information |
| <a name="output_sap_hana_databases_ids"></a> [sap_hana_databases_ids](#output_sap_hana_databases_ids) | Map of SAP HANA databases virtual machines names and its IDs |

## How do I contribute to this Terraform Module?

Contributions are very welcome! Check out the Contribution Guidelines for instructions.

## How is this Terraform Module versioned?

This Terraform Module follows the principles of Semantic Versioning. You can find each new release, along with the changelog, in the Releases Page.

During initial development, the major version will be 0 (e.g., 0.x.y), which indicates the code does not yet have a stable API. Once we hit 1.0.0, we will make every effort to maintain a backwards compatible API and use the MAJOR, MINOR, and PATCH versions on each release to indicate any incompatibilities.

## License

This code is released under the Apache 2.0 License. Please see LICENSE for more details.
<!-- END_TF_DOCS -->