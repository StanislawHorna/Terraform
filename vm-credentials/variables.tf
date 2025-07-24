variable "kv_path" {
  type        = string
  description = "Mount path of the KV, to store VM credentials"
  default     = "proxmox_vms"
}
variable "vm_name" {
  type        = string
  description = "Name of the virtual machine"
}
variable "vm_host" {
  type        = string
  description = "Name of the host where virtual machine will be running"
}
variable "user_name" {
  type        = string
  description = "Username of the account for which credentials will be created"
  default     = "proxmox"
}
variable "vault_url" {
  type        = string
  description = "HashiCorp Vault URL"
  default     = "https://vault.horna.local"
}
variable "vault_role_id" {
  type        = string
  description = "Vault AppRole Role ID"
  sensitive   = true
}
variable "vault_secret" {
  type        = string
  description = "Vault AppRole Secret ID"
  sensitive   = true
}
