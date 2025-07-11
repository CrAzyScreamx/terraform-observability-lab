output "server_ip" {
  value = module.server_vm.vm.private_ip_address
}

output "client_ip" {
  value = module.client_vm.vm.private_ip_address
}
