#### Cloudflare ####
resource "cloudflare_zero_trust_access_policy" "main" {
  count      = var.cloudflare_configuration ? 1 : 0
  account_id = var.cloudflare_account_id
  name       = "Access Policy for ${var.environment_name}-${var.application_name}"
  decision   = "allow"
  include = [{
  everyone = {} }]
}

resource "cloudflare_zero_trust_tunnel_cloudflared" "main" {
  count      = var.cloudflare_configuration ? 1 : 0
  account_id = var.cloudflare_account_id
  name       = "Tunnel Managed by Terraform (${var.environment_name}-${var.application_name})"
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

resource "cloudflare_zero_trust_device_custom_profile" "main" {
  for_each         = var.cloudflare_configuration ? toset(var.subnet_address_prefixes) : []
  account_id       = var.cloudflare_account_id
  name             = "Device Profile - Observability Lab"
  description      = "Managed by Terraform (${var.environment_name}-${var.application_name})"
  enabled          = true
  precedence       = 1
  allowed_to_leave = true
  switch_locked    = false

  match = "os.name in {\"windows\" \"mac\" \"linux\"}"

  include = [{
    address = each.value
  }]
}
#### Cloudflare ####
