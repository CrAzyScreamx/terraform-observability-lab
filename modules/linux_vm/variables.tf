variable "name" {
  type        = string
  description = "The name of the Linux virtual machine."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the Linux virtual machine will be created."
}

variable "location" {
  type        = string
  description = "The Azure region where the Linux virtual machine will be created."
}

variable "size" {
  type        = string
  description = "The size of the Linux virtual machine."
  default     = "Standard_B1s"
}

variable "username" {
  type        = string
  description = "The administrator username for the Linux virtual machine."
  default     = "adminuser"
}

variable "network_interface_ids" {
  type        = list(string)
  description = "A list of network interface IDs to associate with the Linux virtual machine."
}

variable "os_disk_caching" {
  type        = string
  description = "The caching type for the OS disk."
  default     = "ReadWrite"
}

variable "os_disk_storage_account_type" {
  type        = string
  description = "The storage account type for the OS disk."
  default     = "Standard_LRS"
}

variable "source_image_reference" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  description = "The source image reference for the Linux virtual machine."
  default = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

variable "custom_data" {
  type        = string
  description = "Custom data to pass to the Linux virtual machine at creation time."
  default     = null

}
