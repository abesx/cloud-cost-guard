#main.tf
terraform {
  required_version = ">= 1.15"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Read the existing resource group
data "azurerm_resource_group" "main" {
  name = "rg-costguard-dev-weu"
}

resource "azurerm_storage_account" "example" {
  name                     = "xplcgdevstorage001"
  resource_group_name      = data.azurerm_resource_group.main.name
  location                 = data.azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "dev"
    costcenter  = "costguard"
    managedBy   = "terraform"
    workload    = "upskill"
  }

  lifecycle {
    ignore_changes = [
      tags["costcentre"],
      tags["workload"]
    ]
  }
}  