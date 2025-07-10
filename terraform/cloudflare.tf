#### Cloudflare ####
resource "cloudflare_zero_trust_access_policy" "main" {
  count      = var.cloudflare_configuration ? 1 : 0
  account_id = var.cloudflare_account_id
  name       = "Allow Zero Trust Access"
  decision   = "allow"
  include = [{
  everyone = {} }]
}

resource "cloudflare_zero_trust_tunnel_cloudflared" "main" {
  count      = var.cloudflare_configuration ? 1 : 0
  account_id = var.cloudflare_account_id
  name       = "Azure Tunnel (${var.environment_name}-${var.application_name})"
}

resource "cloudflare_zero_trust_tunnel_cloudflared_route" "main" {
  for_each   = var.cloudflare_configuration ? toset(var.subnet_address_prefixes) : []
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.main[0].id
  network    = each.value
}

data "cloudflare_zero_trust_tunnel_cloudflared_token" "main" {
  count      = var.cloudflare_configuration ? 1 : 0
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.main[0].id
}
#### Cloudflare ####
