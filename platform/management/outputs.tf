output "log_analytics_workspace_id" {
  description = "The Resource ID of the central Log Analytics Workspace."
  value       = azurerm_log_analytics_workspace.central.id
}

output "log_analytics_workspace_name" {
  description = "The name of the central Log Analytics Workspace."
  value       = azurerm_log_analytics_workspace.central.name
}

output "action_group_id" {
  description = "The Resource ID of the central security action group."
  value       = azurerm_monitor_action_group.security_ops.id
}