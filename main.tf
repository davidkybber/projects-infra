terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "infra-rg" {
  name     = "infra-resources"
  location = var.location

  tags = {
    Environment = var.environment
  }
}

resource "azurerm_virtual_network" "infra-vnet" {
  name                = "main-network"
  address_space       = [var.vnet_cidr]
  location           = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    Environment = var.environment
  }
}

resource "azurerm_subnet" "infra-subnet" {
  name                 = "public-subnet"
  address_prefixes     = [var.subnet_cidr]
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
} 