variable "location" {
  type        = string
  description = "Azure region for hub networking resources."
  default     = "eastus2"
}

variable "environment" {
  type        = string
  description = "Environment tier."
  default     = "platform"
}

variable "hub_vnet_address_space" {
  type        = list(string)
  description = "CIDR block for the Hub Virtual Network."
  default     = ["10.100.0.0/16"]
}

variable "firewall_sku_tier" {
  type        = string
  description = "Azure Firewall SKU Tier (Standard or Premium)."
  default     = "Standard"
}