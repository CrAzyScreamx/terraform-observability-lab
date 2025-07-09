variable "nic_name" {
  type        = string
  description = "The name of the network interface."
  default     = "nic"
}

variable "location" {
  type        = string
  description = "The Azure region where the network interface will be created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the network interface will be created."
}

variable "ip_configuration_name" {
  type        = string
  description = "The name of the IP configuration for the network interface."
  default     = "internal"
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet to which the network interface will be connected."
}

variable "private_ip_address_allocation" {
  type        = string
  description = "The private IP address allocation method (Dynamic or Static)."
  default     = "Dynamic"
}

variable "private_ip_address" {
  type        = string
  description = "The private IP address to assign to the network interface if using Static allocation."
  default     = null
}
