terraform {
  required_version = ">= 1.6.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.85.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-platform-tfstate-eastus2"
    storage_account_name = "stplfstate001"
    container_name       = "tfstate-vending"
    key                  = "vending.tfstate"
  }
}

provider "azurerm" {
  features {
    subscription {
      prevent_cancellation_on_destroy = true
    }
  }
}