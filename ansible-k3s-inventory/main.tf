# Extract unique cluster prefixes from vm tags
# Tag must match the format 'k3s_cluster_<env>_<role>
locals {
  cluster_tags = distinct(flatten([
    for vm in var.ubuntu_vms : [
      for tag in vm.tags : (
        can(regex("^(k3s_cluster_[a-z]+)_(agent|server)$", tag)) ?
        regex("^(k3s_cluster_[a-z]+)_(agent|server)$", tag)[0] : null
      )
    ]
  ]))

  cluster_names = [for tag in local.cluster_tags : tag if tag != null]
}

# Create a map of nodes in each cluster
locals {
  cluster_vm_map = {
    for cluster in local.cluster_names : cluster => {
      for name, vm in var.ubuntu_vms :
      name => vm
      if anytrue([
        for tag in vm.tags : startswith(tag, "${cluster}_")
      ])
    }
  }
}

# Interate over map and create separate file for each cluster
resource "local_file" "ansible_inventory" {
  for_each = local.cluster_vm_map

  filename = "${var.output_path}/${each.key}.ini"
  content = templatefile("${path.module}/inventory.tpl", {
    vms            = each.value
    cluster_prefix = each.key
    cluster_suffix = replace(each.key, "k3s_cluster_", "")
  })
}
