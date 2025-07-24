locals {
  grouped_hosts = {
    for tag in distinct(flatten([
      for _, vm in var.ubuntu_vms : vm.tags
    ])) :
    tag => [
      for name, vm in var.ubuntu_vms :
      "${name} ansible_host=${vm.ip_address} ansible_user=${var.ansible_user} vault_path=proxmox_vms/data/${var.target_node}-${name}-${var.ansible_user}"
      if contains(vm.tags, tag)
    ]
  }

  ansible_inventory_content = join("\n\n", [
    for tag, hosts in local.grouped_hosts :
    "[${tag}]\n${join("\n", hosts)}"
  ])
}

resource "local_file" "ansible_inventory" {
  content  = local.ansible_inventory_content
  filename = var.output_path
}
