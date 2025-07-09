resource "azurerm_network_security_rule" "network_security_rules" {
  for_each = { for rule in var.rules : "${rule.nsg}-${rule.name}" => rule }

  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = var.direction
  access                      = "Allow"
  protocol                    = "Tcp"
  resource_group_name         = var.resource_group_name
  network_security_group_name = each.value.nsg
  source_port_range           = each.value.port

  destination_port_range     = each.value.port
  source_address_prefix      = "*"
  destination_address_prefix = "*"
}
