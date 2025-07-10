output "tls_private_key" {
  value = tls_private_key.user-key
}

output "vm" {
  value = azurerm_linux_virtual_machine.vm
}
