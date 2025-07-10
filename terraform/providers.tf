terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~>4"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~>5.6.0"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

provider "cloudflare" {}
