data "azuread_group" "network_admins" {
  display_name     = var.network_admin_group_name
  security_enabled = true
}

data "azuread_group" "security_admins" {
  display_name     = var.security_admin_group_name
  security_enabled = true
}

# Assign Network Contributor role at Platform Management Group Scope
resource "azurerm_role_assignment" "network_admin" {
  scope                = var.platform_mg_id
  role_definition_name = "Network Contributor"
  principal_id         = data.azuread_group.network_admins.object_id
}

# Assign Security Reader role at Platform Management Group Scope
resource "azurerm_role_assignment" "security_admin" {
  scope                = var.platform_mg_id
  role_definition_name = "Security Reader"
  principal_id         = data.azuread_group.security_admins.object_id
}