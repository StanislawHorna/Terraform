resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "random_password" "vm_password" {
  length  = 16
  special = true
}
resource "vault_kv_secret_v2" "cred_storage" {
  depends_on = [random_password.vm_password, tls_private_key.rsa]
  mount      = var.kv_path
  name       = "${var.vm_host}-${var.vm_name}-${var.user_name}"

  data_json = jsonencode({
    username    = var.user_name
    password    = random_password.vm_password.result
    private_key = tls_private_key.rsa.private_key_pem
    public_key  = tls_private_key.rsa.public_key_pem
    public_key_ssh = tls_private_key.rsa.public_key_openssh

  })
}

