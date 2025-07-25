variable "ubuntu_vms" {
  description = "Map of VMs with IPs and tags"
  type = map(object({
    vm_desc      = string
    target_node  = string
    ip_address   = string
    cidr_netmask = string
    gateway      = string
    tags         = list(string)
  }))
}

variable "ansible_user" {
  description = "Default SSH user for Ansible"
  type        = string
  default     = "ubuntu"
}

variable "output_path" {
  description = "Path to write the generated inventory file"
  type        = string
}

