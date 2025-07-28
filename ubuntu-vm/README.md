# Proxmox Ubuntu Server VM

This module requires proxmox vm template named `ubuntu-cloud-init-template`.
Operation procedure of how to create such template can be found [here](/docs/ubuntu-cloud-init-template.md)

### Prerequisites

- HashiCorp Vault instance with AppRole authentication method enabled,

  - Secret entry storing Proxmox connection details:
  - `proxmox_api_url` - URL to to your Proxmox Machine API (`https://<proxmox_name_or_ip>:8006/api2/json`)
  - `proxmox_api_token_ids` - Proxmox API token ID ([Proxmox VE API - Docs](https://pve.proxmox.com/wiki/Proxmox_VE_API#API_Tokens))
  - `proxmox_api_token_secrets` - Proxmox API token Secret ([Proxmox VE API - Docs](https://pve.proxmox.com/wiki/Proxmox_VE_API#API_Tokens))

- proxmox vm template named `ubuntu-cloud-init-template` - SOP how to create it can be found [here](/docs/ubuntu-cloud-init-template.md).

## Provider block

Block below should be placed in the root Terraform project, with updated values:

- `<HCP_url>` - URL to your HashiCorp Vault instance
- `<HCP_app_role_role_id>` - AppRole's role id to authenticate to HCP Vault instance
- `<HCP_app_role_secret_id>` - AppRole's secret id to authenticate to HCP Vault instance
- `<HCP_path_to_your_proxmox_credentials>` - HCP Vault's path to secret entry containing Proxmox credentials.

```HCL
terraform {
  required_version = ">= 0.13.0"

  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc6"
    }
  }
}
provider "vault" {
  address = "<HCP_url>"

  # AppRole authentication
  auth_login {
    path = "auth/approle/login"
    parameters = {
      role_id   = "<HCP_app_role_role_id>"
      secret_id = "<HCP_app_role_secret_id>"
    }
  }
}

data "vault_generic_secret" "pve_creds" {
  path = "<HCP_path_to_your_proxmox_credentials>"
}

provider "proxmox" {
  pm_api_url          = data.vault_generic_secret.pve_creds.data["proxmox_api_url"]
  pm_api_token_id     = data.vault_generic_secret.pve_creds.data["proxmox_api_token_id"]
  pm_api_token_secret = data.vault_generic_secret.pve_creds.data["proxmox_api_token_secret"]
  pm_tls_insecure     = true
}
```
