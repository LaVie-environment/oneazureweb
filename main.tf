# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}

  subscription_id = "61230797-2385-4403-8a23-553c4a8da920"
  client_id       = "bd330f5d-22ed-487c-b29d-5d8e88eff76f"
  tenant_id       = "cfd11325-8f42-48d9-8d1a-dd495c0916ae"
  client_secret   = "VDa8Q~asta-4OBc~kzb-sWxHjL0rnC4hh~wV2b-2"
    
}

resource "azurerm_resource_group" "rg" {
  name     = "myTFResourceGroup"
  location = "westus2"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "panta" {
  name                = "pantan-network"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]
}