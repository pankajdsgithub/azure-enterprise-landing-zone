data "azurerm_client_config" "current" {}

# Enable Microsoft Defender for Cloud on the Subscription

resource "azurerm_security_center_subscription_pricing" "defender_servers" {
tier          = "Standard"
resource_type = "VirtualMachines"
}

resource "azurerm_security_center_subscription_pricing" "defender_storage" {
tier          = "Standard"
resource_type = "StorageAccounts"
}

resource "azurerm_security_center_subscription_pricing" "defender_keyvault" {
tier          = "Standard"
resource_type = "KeyVaults"
}


# Configure Security Contacts

resource "azurerm_security_center_contact" "secops" {
name                  = "EnterpriseSecOpsContact"
email                 = var.security_contact_email
phone                 = "+15555555555"
alert_notifications   = true
alerts_to_admins      = true
}