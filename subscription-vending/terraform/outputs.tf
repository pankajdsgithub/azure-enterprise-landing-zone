output "vended_subscription_id" {
  description = "The Subscription ID of the newly provisioned workload subscription."
  value       = azurerm_subscription.workload.subscription_id
}

output "vended_subscription_name" {
  description = "The display name of the newly provisioned subscription."
  value       = azurerm_subscription.workload.subscription_name
}

output "subscription_alias_id" {
  description = "The Resource ID of the subscription alias."
  value       = azurerm_subscription.workload.id
}