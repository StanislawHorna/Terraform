output "private_key_pem" {
  value     = tls_private_key.rsa.private_key_pem
  sensitive = true
}
output "public_key_pem" {
  value = tls_private_key.rsa.public_key_pem
}
output "public_key_ssh" {
  value = tls_private_key.rsa.public_key_openssh
}
output "vm_password" {
  value     = random_password.vm_password.result
  sensitive = true
}
output "vm_username" {
  value = var.user_name
}