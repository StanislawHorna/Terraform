variable "vm_name" {
  description = "The name of the VM"
  type        = string
}
variable "vm_desc" {
  description = "The description of the VM"
  type        = string

}
variable "vmid" {
  description = "The VMID of the VM"
  type        = number
  default     = null
}
variable "tags" {
  description = "The tags of the VM"
  type        = list(string)
  default     = null
}
variable "target_node" {
  description = "The target node to deploy the VM"
  type        = string
  default     = "pve-r7"
}
variable "cores" {
  description = "The number of cores"
  type        = number
  default     = 4
}
variable "memory" {
  description = "The amount of memory"
  type        = number
  default     = 4096
}
variable "disk_size" {
  description = "The size of the disk"
  type        = string
  default     = "64G"
}
variable "ip_address" {
  description = "The ip address of the VM"
  type        = string
}
variable "cidr_netmask" {
  description = "The netmask of the VM in format like 24"
  type        = number
}
variable "gateway" {
  description = "The gateway of the VM"
  type        = string
}
variable "dns_servers" {
  description = "The dns servers of the VM"
  type        = list(string)
  default     = ["1.1.1.1"]
}
variable "hcp_vault_url" {
  type    = string
  default = "https://vault.horna.local"
}
variable "hcp_vault_role_id" {
  type      = string
  sensitive = true
}
variable "hcp_vault_secret" {
  type      = string
  sensitive = true
}
