data "azurerm_client_config" "current" {}

locals {
  root_mg_id = "/providers/Microsoft.Management/managementGroups/${data.azurerm_client_config.current.tenant_id}"
}

# Policy Assignment: Allowed Locations
resource "azurerm_management_group_policy_assignment" "allowed_locations" {
  name                 = "audit-allowed-locations"
  display_name         = "Audit Allowed Azure Regions"
  management_group_id  = local.root_mg_id
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c" # Built-in: Allowed locations

  parameters = jsonencode({
    listOfAllowedLocations = {
      value = var.allowed_locations
    }
  })
}

# Policy Assignment: Enforce Secure Transport (HTTPS/TLS) for Storage Accounts
resource "azurerm_management_group_policy_assignment" "secure_storage" {
  name                 = "enforce-storage-https"
  display_name         = "Enforce secure transfer to storage accounts"
  management_group_id  = local.root_mg_id
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/404c3081-a854-4457-ae30-26a93ef643f9" # Built-in
}