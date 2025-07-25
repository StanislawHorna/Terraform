[agent]
%{ for name, vm in vms ~}
%{ if length([for tag in vm.tags : tag if tag == "${cluster_prefix}_agent"]) > 0 }
${name} ansible_host=${vm.ip_address} ansible_user=proxmox vault_path=proxmox_vms/data/${vm.target_node}-${name}-proxmox
%{ endif }
%{ endfor }

[server]
%{ for name, vm in vms ~}
%{ if length([for tag in vm.tags : tag if tag == "${cluster_prefix}_server"]) > 0 }
${name} ansible_host=${vm.ip_address} ansible_user=proxmox vault_path=proxmox_vms/data/${vm.target_node}-${name}-proxmox
%{ endif }
%{ endfor }

[${cluster_prefix}]
%{ for name, vm in vms ~}
${name} ansible_host=${vm.ip_address} ansible_user=proxmox vault_path=proxmox_vms/data/${vm.target_node}-${name}-proxmox
%{ endfor }