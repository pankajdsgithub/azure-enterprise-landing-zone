output "network_admin_assignment_id" {
  description = "Role assignment ID for Network Administrators."
  value       = azurerm_role_assignment.network_admin.id
}

output "security_admin_assignment_id" {
  description = "Role assignment ID for Security Administrators."
  value       = azurerm_role_assignment.security_admin.id
}