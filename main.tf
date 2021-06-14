terraform {
  required_version = "= 1.0.0"
}

provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
}


resource "azurerm_resource_group" "devops-challenge-rg" {
  name     = "devops-challenge-rg"
  location = var.location
}














