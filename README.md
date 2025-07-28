# Terraform

A collection of Terraform modules designed to automate provisioning
and configuration of internal Home Lab infrastructure.

## Modules

### [vm-credentials](/vm-credentials/)

Generates a secure random password and SSH key pair for virtual machines.
Credentials are securely stored in HashiCorp Vault for future retrieval and usage.

### [ubuntu-vm](/ubuntu-vm/)

Provisions virtual machines on Proxmox VE, using the [telmate/proxmox](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs) Terraform provider.
This module also integrates with the [vm-credentials](/vm-credentials/)
module to create and manage VM credentials stored in HCP Vault.

### [ansible-vm-inventory](/ansible-vm-inventory/)

Generates a dynamic Ansible inventory based on Proxmox VM tags, grouping hosts by shared tags.

### [ansible-k3s-inventory](/ansible-k3s-inventory/)

Creates Ansible inventory files for k3s clusters, based on tagged Proxmox VMs.
VM tags must follow this format: `k3s_cluster_<cluster_name>_<node_role>`

- `<cluster_name>` - Identifies the k3s cluster the VM belongs to.
- `<node_role>` - Defines the role of the VM in the cluster. Supported roles:
  - `server` - The control plane node of the k3s cluster.
  - `agent` - A worker node that runs workloads.
