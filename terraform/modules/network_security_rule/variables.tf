variable "rules" {
  type = list(object({
    name                       = string
    priority                   = number
    nsg                        = string
    port                       = string
    access                     = optional(string, "Allow")
    protocol                   = optional(string, "Tcp")
    source_address_prefix      = optional(string, "*")
    destination_address_prefix = optional(string, "*")
  }))
}

variable "resource_group_name" {
  type = string
}

variable "direction" {
  type    = string
  default = "Inbound"
}
