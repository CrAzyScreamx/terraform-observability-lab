variable "environment_name" {
  type        = string
  description = "The value of the environment name"
}

variable "application_name" {
  type        = string
  description = "The value of the application name"
}

variable "azure_location" {
  type        = string
  description = "The value of the Azure location"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "The address space for the subnet in CIDR notation"
  default     = ["10.0.0.0/16"]
}

variable "subnet_address_prefixes" {
  type        = list(string)
  description = "The address prefixes for the subnet in CIDR notation"
  default     = ["10.0.2.0/24"]
}

variable "client_count" {
  type        = number
  description = "The number of clients to create"
  default     = 1
}
