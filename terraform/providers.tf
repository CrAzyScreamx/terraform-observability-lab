terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.35.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~>4.0.3"
    }
  }
}

provider "azurerm" {
  features {}
}
