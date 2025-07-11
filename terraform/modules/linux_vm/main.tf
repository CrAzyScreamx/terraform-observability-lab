# Creating a key
resource "tls_private_key" "user-key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                  = var.name
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.size
  admin_username        = var.username
  network_interface_ids = var.network_interface_ids
  provision_vm_agent    = true

  # Temp
  disable_password_authentication = false
  admin_password                  = "Aa12345"


  admin_ssh_key {
    username   = var.username
    public_key = tls_private_key.user-key.public_key_openssh
  }

  os_disk {
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = var.source_image_reference.publisher
    offer     = var.source_image_reference.offer
    sku       = var.source_image_reference.sku
    version   = var.source_image_reference.version
  }

  custom_data = var.custom_data
}
