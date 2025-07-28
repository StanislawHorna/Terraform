# Ansible K3s Inventory

This Terraform module parses VM tags to identify nodes that belong to specific k3s clusters
and generates a dedicated Ansible inventory .ini file for each detected cluster.

It is designed to work with Proxmox virtual machines that use tags in the following format:

```
k3s_cluster_<cluster_name>_<role>
```

Where:

- `<cluster_name>` is the unique identifier or environment for the cluster (e.g., dev, prod, lab).
- `<role>` is either `server` (control plane node) or `agent` (worker node).

Each inventory entry also includes a vault_path, which points to the corresponding location in HashiCorp Vault where VM credentials are securely stored. This allows for seamless integration with secure automation workflows.
