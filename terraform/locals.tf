locals {
  network_security_rules = [
    # {
    #   name     = "allow-ssh-server"
    #   priority = 1000
    #   nsg      = azurerm_network_security_group.server.name
    #   port     = "22"
    # },
    {
      name     = "allow-ssh-client"
      priority = 1000
      nsg      = azurerm_network_security_group.client.name
      port     = "22"
    },
    {
      name     = "allow-http"
      priority = 1010
      nsg      = azurerm_network_security_group.server.name
      port     = "80"
    },
    {
      name     = "allow-https"
      priority = 1020
      nsg      = azurerm_network_security_group.server.name
      port     = "443"
    }
  ]
}
