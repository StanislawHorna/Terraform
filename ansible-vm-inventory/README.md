# Ansible VM Inventory

This module processes a list of Ubuntu VMs with associated tags and generates a single Ansible inventory file.
VMs are grouped into host groups based on their tags,
simplifying the organization and targeting of specific machines in Ansible playbooks.
Each entry also includes a `vault_path`,
which points to the location in HashiCorp Vault where the VM’s credentials are securely stored.

## Example Output

Given the following VM definitions:

```HCL
ubuntu_vms = {
  "vm1" = {
    ip_address  = "10.0.0.1"
    tags        = ["web", "dev"]
    target_node = "pve1"
  },
  "vm2" = {
    ip_address  = "10.0.0.2"
    tags        = ["web", "prod"]
    target_node = "pve2"
  }
}
```

The generated file might look like:

```ini
[web]
vm1 ansible_host=10.0.0.1 ansible_user=ubuntu vault_path=proxmox_vms/data/pve1-vm1-ubuntu
vm2 ansible_host=10.0.0.2 ansible_user=ubuntu vault_path=proxmox_vms/data/pve2-vm2-ubuntu

[dev]
vm1 ansible_host=10.0.0.1 ansible_user=ubuntu vault_path=proxmox_vms/data/pve1-vm1-ubuntu

[prod]
vm2 ansible_host=10.0.0.2 ansible_user=ubuntu vault_path=proxmox_vms/data/pve2-vm2-ubuntu
```
