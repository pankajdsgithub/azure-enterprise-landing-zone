output "storage_account_name" {
  description = "The name of the Terraform state storage account."
  value       = azurerm_storage_account.tfstate.name
}

output "resource_group_name" {
  description = "The name of the resource group holding state resources."
  value       = azurerm_resource_group.tfstate.name
}

output "container_names" {
  description = "The list of created state containers."
  value       = [for c in azurerm_storage_container.containers : c.name]
}