locals {
  network_security_rules = [
    {
      name      = "deny-ssh-client"
      priority  = 100
      nsg       = azurerm_network_security_group.client.name
      port      = "22"
      access    = "Deny"
      protocol  = "Tcp"
      direction = "Inbound"
    }
  ]
}
