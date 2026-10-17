output "hub_vnet_id" {
  description = "The Resource ID of the Hub VNet."
  value       = azurerm_virtual_network.hub.id
}

output "hub_vnet_name" {
  description = "The name of the Hub VNet."
  value       = azurerm_virtual_network.hub.name
}

output "firewall_private_ip" {
  description = "Private IP address of the Azure Firewall for routing spoke UDRs."
  value       = azurerm_firewall.hub.ip_configuration[0].private_ip_address
}

output "private_dns_zone_ids" {
  description = "Map of created Private DNS Zone IDs."
  value       = { for k, v in azurerm_private_dns_zone.zones : k => v.id }
}