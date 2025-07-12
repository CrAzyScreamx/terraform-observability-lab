# Environment Variables
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

# Cloudflare Variables
variable "cloudflare_account_id" {
  type        = string
  description = "The Cloudflare account ID"
  sensitive   = true
  default     = null
}

variable "cloudflare_configuration" {
  type        = bool
  description = "Flag to enable or disable Cloudflare configuration"
  default     = true
}


# Grafana And Prometheus variables
variable "grafana_admin_user" {
  type        = string
  description = "The Grafana admin username"
  default     = "admin"
}

variable "grafana_admin_password" {
  type        = string
  description = "The Grafana admin password"
  sensitive   = true
}

variable "node_explorer_port" {
  type        = number
  description = "The port for Node Exporter"
  default     = 9100
}
