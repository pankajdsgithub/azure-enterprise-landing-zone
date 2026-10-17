output "root_management_group_id" {
  description = "The ID of the tenant root management group."
  value       = azurerm_management_group.root.id
}

output "platform_management_group_id" {
  description = "The ID of the Platform management group."
  value       = azurerm_management_group.platform.id
}

output "landing_zones_management_group_id" {
  description = "The ID of the Landing Zones management group."
  value       = azurerm_management_group.landing_zones.id
}