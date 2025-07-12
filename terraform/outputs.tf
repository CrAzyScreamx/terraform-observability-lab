output "server_ip" {
  value = module.server_vm.vm.private_ip_address
}

output "client_ip" {
  value = [
    for nic in azurerm_network_interface.client_nic : nic.ip_configuration[0].private_ip_address
  ]
}
