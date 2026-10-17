variable "billing_account_name" {
  type        = string
  description = "EA Billing Account ID / Number."
  default     = "12345678"
}

variable "enrollment_account_name" {
  type        = string
  description = "EA Enrollment Account Name / Number."
  default     = "87654321"
}

variable "subscription_name" {
  type        = string
  description = "Display name of the new workload subscription."
  default     = "sub-app1-prod-01"
}

variable "workload_type" {
  type        = string
  description = "Workload classification type (Production or DevTest)."
  default     = "Production"
}

variable "target_management_group_id" {
  type        = string
  description = "Resource ID of the target Management Group (e.g., Production or Non-Production MG)."
  default     = "/providers/Microsoft.Management/managementGroups/ent-lz-prod"
}