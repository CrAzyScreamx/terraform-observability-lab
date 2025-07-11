resource "azurerm_resource_group" "main" {
  name     = "rg-${var.environment_name}-${var.application_name}"
  location = var.azure_location
}

resource "azurerm_virtual_network" "main" {
  name                = "vnet-${var.environment_name}-${var.application_name}"
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "main" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.subnet_address_prefixes
}

resource "azurerm_network_security_group" "server" {
  name                = "nsg-${var.environment_name}-${var.application_name}-server"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_network_security_group" "client" {
  name                = "nsg-${var.environment_name}-${var.application_name}-client"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

## NSG Rules
module "nsg_rules" {
  source              = "./modules/network_security_rule"
  resource_group_name = azurerm_resource_group.main.name
  rules               = local.network_security_rules

}

#### Server VM Configuration ####

# A Network interface for the Server VM
module "server_nic" {
  source                = "./modules/network_interface"
  nic_name              = "nic-${var.environment_name}-${var.application_name}"
  location              = azurerm_resource_group.main.location
  resource_group_name   = azurerm_resource_group.main.name
  ip_configuration_name = "internal"
  subnet_id             = azurerm_subnet.main.id
}

### Server VM Creation ###
module "server_vm" {
  depends_on            = [data.cloudflare_zero_trust_tunnel_cloudflared_token.main]
  source                = "./modules/linux_vm"
  name                  = "vm-${var.environment_name}-${var.application_name}-server"
  resource_group_name   = azurerm_resource_group.main.name
  location              = azurerm_resource_group.main.location
  network_interface_ids = [module.server_nic.id]

  custom_data = base64encode(templatefile("/setupFiles/server.sh", {
    github_key   = base64encode(file("keys/github.key")) # Private Repo Access Key
    cloudflare   = var.cloudflare_configuration
    tunnel_token = data.cloudflare_zero_trust_tunnel_cloudflared_token.main[0].token
  }))
}

resource "local_sensitive_file" "private_key" {
  content  = module.server_vm.tls_private_key.private_key_pem
  filename = "keys/private_key.pem"
}
### Server VM Creation ###

#### Server VM Configuration ####

#### Client VM Configuration ####

# A Network interface for the Client VM
module "client_nic" {
  source                = "./modules/network_interface"
  nic_name              = "nic-${var.environment_name}-${var.application_name}-client"
  location              = azurerm_resource_group.main.location
  resource_group_name   = azurerm_resource_group.main.name
  ip_configuration_name = "internal"
  subnet_id             = azurerm_subnet.main.id
}

### NIC Association with NSG for Client VM ###
resource "azurerm_network_interface_security_group_association" "client" {
  network_interface_id      = module.client_nic.id
  network_security_group_id = azurerm_network_security_group.client.id
}

### Client VM Creation ###
module "client_vm" {
  source                = "./modules/linux_vm"
  name                  = "vm-${var.environment_name}-${var.application_name}-client"
  resource_group_name   = azurerm_resource_group.main.name
  location              = azurerm_resource_group.main.location
  network_interface_ids = [module.client_nic.id]
}

resource "local_sensitive_file" "client_private_key" {
  content  = module.client_vm.tls_private_key.private_key_pem
  filename = "keys/client_private_key.pem"
}
## Client VM Creation ###


