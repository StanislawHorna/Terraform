# Proxmox Ubuntu Server VM

This module requires proxmox vm template named `ubuntu-cloud-init-template`. 


## Credentials
File `credentials.auto.tfvars` should be located in root, where this module is used in format:

```
proxmox_api_url = "https://<server_ip_address>:8006/api2/json"  # Your Proxmox IP Address
proxmox_api_token_id = "<your-api-token-id>"  # API Token ID
proxmox_api_token_secret = "<your-api-token-secret>"
```

To make credentials file working you also need additional `variables.tf` file beside the `credentials.auto.tfvars`, in format

```
variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token_id" {
  type = string
}

variable "proxmox_api_token_secret" {
  type = string
}

```

## Provider block

```
terraform {
  required_version = ">= 0.13.0"

  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc6"
    }
  }
}

provider "proxmox" {
  pm_api_url          = data.vault_generic_secret.pve_creds.data["proxmox_api_url"]
  pm_api_token_id     = data.vault_generic_secret.pve_creds.data["proxmox_api_token_id"]
  pm_api_token_secret = data.vault_generic_secret.pve_creds.data["proxmox_api_token_secret"]
  pm_tls_insecure     = true
}
```