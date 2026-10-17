#### 5. Exact Path: `platform/security/outputs.tf`

output "defender_servers_tier" {
  description = "Defender pricing tier for virtual machines."
  value       = azurerm_security_center_subscription_pricing.defender_servers.tier
}