resource "azurerm_resource_group" "connectivity" {
  name     = "rg-platform-connectivity-${var.location}"
  location = var.location
  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Purpose     = "Central Hub Networking"
  }
}

# Hub Virtual Network
resource "azurerm_virtual_network" "hub" {
  name                = "vnet-hub-${var.location}"
  location            = azurerm_resource_group.connectivity.location
  resource_group_name = azurerm_resource_group.connectivity.name
  address_space       = var.hub_vnet_address_space

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Required Hub Subnets
resource "azurerm_subnet" "firewall" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.connectivity.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = ["10.100.1.0/24"]
}

resource "azurerm_subnet" "gateway" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.connectivity.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = ["10.100.2.0/24"]
}

resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.connectivity.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = ["10.100.3.0/24"]
}

resource "azurerm_subnet" "shared_services" {
  name                 = "snet-shared-services"
  resource_group_name  = azurerm_resource_group.connectivity.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = ["10.100.4.0/24"]
}

# Public IP for Azure Firewall
resource "azurerm_public_ip" "afw" {
  name                = "pip-afw-${var.location}"
  location            = azurerm_resource_group.connectivity.location
  resource_group_name = azurerm_resource_group.connectivity.name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Azure Firewall Policy
resource "azurerm_firewall_policy" "hub" {
  name                = "afwp-hub-${var.location}"
  resource_group_name = azurerm_resource_group.connectivity.name
  location            = azurerm_resource_group.connectivity.location
  sku                 = var.firewall_sku_tier
}

# Azure Firewall Instance
resource "azurerm_firewall" "hub" {
  name                = "afw-hub-${var.location}"
  location            = azurerm_resource_group.connectivity.location
  resource_group_name = azurerm_resource_group.connectivity.name
  sku_name            = "AZFW_VNet"
  sku_tier            = var.firewall_sku_tier
  firewall_policy_id  = azurerm_firewall_policy.hub.id

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.firewall.id
    public_ip_address_id = azurerm_public_ip.afw.id
  }

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Central Private DNS Zones for PaaS Integration
locals {
  private_dns_zones = [
    "privatelink.blob.core.windows.net",
    "privatelink.vaultcore.azure.net",
    "privatelink.database.windows.net",
    "privatelink.azurecr.io",
    "privatelink.servicebus.windows.net"
  ]
}

resource "azurerm_private_dns_zone" "zones" {
  for_each            = toset(local.private_dns_zones)
  name                = each.value
  resource_group_name = azurerm_resource_group.connectivity.name

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "hub_links" {
  for_each              = azurerm_private_dns_zone.zones
  name                  = "link-${each.value.name}-hub"
  resource_group_name   = azurerm_resource_group.connectivity.name
  private_dns_zone_name = each.value.name
  virtual_network_id    = azurerm_virtual_network.hub.id
  registration_enabled  = false

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}