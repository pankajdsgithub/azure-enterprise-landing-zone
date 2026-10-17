resource "azurerm_resource_group" "management" {
  name     = "rg-platform-management-${var.location}"
  location = var.location
  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Purpose     = "Central Logging and Monitoring"
  }
}

# Central Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "central" {
  name                = "log-platform-central-${var.location}"
  location            = azurerm_resource_group.management.location
  resource_group_name = azurerm_resource_group.management.name
  sku                 = "PerGB2018"
  retention_in_days   = var.log_retention_in_days

  # Enterprise security setting: Disable public network access for ingestion if required, 
  # or rely on workspace data export controls.
  internet_ingestion_enabled = true
  internet_query_enabled     = true

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Action Group for Critical Platform Alerts
resource "azurerm_monitor_action_group" "security_ops" {
  name                = "ag-platform-security-ops"
  resource_group_name = azurerm_resource_group.management.name
  short_name          = "SecOpsAlerts"

  email_receiver {
    name                    = "SecOpsEmail"
    email_address           = var.alert_email
    use_common_alert_schema = true
  }

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Central Automation Account for Update Management / Governance runbooks (Optional companion)
resource "azurerm_automation_account" "central" {
  name                = "aa-platform-central-${var.location}"
  location            = azurerm_resource_group.management.location
  resource_group_name = azurerm_resource_group.management.name
  sku_name            = "Basic"

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}