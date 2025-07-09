variable "rules" {
  type = list(object({
    name     = string
    priority = number
    nsg      = string
    port     = string
  }))
}

variable "resource_group_name" {
  type = string
}

variable "direction" {
  type    = string
  default = "Inbound"
}
