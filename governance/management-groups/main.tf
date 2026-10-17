data "azurerm_client_config" "current" {}

locals {
  tenant_id = data.azurerm_client_config.current.tenant_id
}

# Tenant Root Management Group (Parent is Tenant ID)
resource "azurerm_management_group" "root" {
  name                       = local.tenant_id
  display_name               = var.root_mg_display_name
}

# Platform Management Group
resource "azurerm_management_group" "platform" {
  name                       = "${var.prefix}-platform"
  display_name               = "Platform"
  parent_management_group_id = azurerm_management_group.root.id
}

resource "azurerm_management_group" "management" {
  name                       = "${var.prefix}-platform-management"
  display_name               = "Management"
  parent_management_group_id = azurerm_management_group.platform.id
}

resource "azurerm_management_group" "connectivity" {
  name                       = "${var.prefix}-platform-connectivity"
  display_name               = "Connectivity"
  parent_management_group_id = azurerm_management_group.platform.id
}

# Landing Zones Management Group
resource "azurerm_management_group" "landing_zones" {
  name                       = "${var.prefix}-landing-zones"
  display_name               = "Landing Zones"
  parent_management_group_id = azurerm_management_group.root.id
}

resource "azurerm_management_group" "prod" {
  name                       = "${var.prefix}-lz-prod"
  display_name               = "Production"
  parent_management_group_id = azurerm_management_group.landing_zones.id
}

resource "azurerm_management_group" "nonprod" {
  name                       = "${var.prefix}-lz-nonprod"
  display_name               = "Non-Production"
  parent_management_group_id = azurerm_management_group.landing_zones.id
}

# Sandbox Management Group
resource "azurerm_management_group" "sandbox" {
  name                       = "${var.prefix}-sandbox"
  display_name               = "Sandbox"
  parent_management_group_id = azurerm_management_group.root.id
}

# Decommissioned Management Group
resource "azurerm_management_group" "decommissioned" {
  name                       = "${var.prefix}-decommissioned"
  display_name               = "Decommissioned"
  parent_management_group_id = azurerm_management_group.root.id
}