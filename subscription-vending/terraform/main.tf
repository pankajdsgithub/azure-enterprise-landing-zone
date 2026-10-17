# Reference the EA Billing Scope
data "azurerm_billing_enrollment_account_scope" "enrollment" {
  billing_account_name    = var.billing_account_name
  enrollment_account_name = var.enrollment_account_name
}

# Provision the Azure Subscription via ARM Alias API
resource "azurerm_subscription" "workload" {
  subscription_name = var.subscription_name
  billing_scope_id  = data.azurerm_billing_enrollment_account_scope.enrollment.id
  workload          = var.workload_type

  tags = {
    Environment = "production"
    ManagedBy   = "Terraform-Vending"
  }
}

# Automatically associate the vended subscription with the correct Management Group
resource "azurerm_management_group_subscription_association" "placement" {
  management_group_id = var.target_management_group_id
  subscription_id     = azurerm_subscription.workload.subscription_id
}