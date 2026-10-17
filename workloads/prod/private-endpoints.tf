# Private Endpoint for Application Key Vault
resource "azurerm_private_endpoint" "kv" {
  name                = "pep-${var.application_name}-kv-${var.environment}"
  location            = azurerm_resource_group.workload.location
  resource_group_name = azurerm_resource_group.workload.name
  subnet_id           = azurerm_subnet.endpoints.id

  private_service_connection {
    name                           = "psc-${var.application_name}-kv"
    private_connection_resource_id = azurerm_key_vault.vault.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }

  tags = {
    Environment = var.environment
  }
}

# Private Endpoint for Azure Container Registry
resource "azurerm_private_endpoint" "acr" {
  name                = "pep-${var.application_name}-acr-${var.environment}"
  location            = azurerm_resource_group.workload.location
  resource_group_name = azurerm_resource_group.workload.name
  subnet_id           = azurerm_subnet.endpoints.id

  private_service_connection {
    name                           = "psc-${var.application_name}-acr"
    private_connection_resource_id = azurerm_container_registry.acr.id
    is_manual_connection           = false
    subresource_names              = ["registry"]
  }

  tags = {
    Environment = var.environment
  }
}