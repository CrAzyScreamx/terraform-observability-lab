locals {
  client_nic_ids = [for nic in module.client_nic : nic.id]
}
