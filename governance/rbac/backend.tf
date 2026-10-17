terraform {
  required_version = ">= 1.6.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.85.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.47.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-platform-tfstate-eastus2"
    storage_account_name = "stplfstate001"
    container_name       = "tfstate-governance"
    key                  = "rbac.tfstate"
  }
}

provider "azurerm" {
  features {}
}

provider "azuread" {}