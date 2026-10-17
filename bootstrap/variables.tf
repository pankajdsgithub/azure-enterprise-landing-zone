variable "location" {
  type        = string
  description = "Azure region for bootstrap resources."
  default     = "eastus2"
}

variable "environment" {
  type        = string
  description = "Environment name for tagging and naming."
  default     = "platform"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group for Terraform state storage."
  default     = "rg-platform-tfstate-eastus2"
}

variable "storage_account_name" {
  type        = string
  description = "Globally unique name for the Terraform state storage account."
  default     = "stplfstate001"
}

variable "container_names" {
  type        = list(string)
  description = "List of blob container names for isolated state boundaries."
  default = [
    "tfstate-bootstrap",
    "tfstate-governance",
    "tfstate-connectivity",
    "tfstate-management",
    "tfstate-vending",
    "tfstate-workloads"
  ]
}