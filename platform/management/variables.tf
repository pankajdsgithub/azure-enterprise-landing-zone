variable "location" {
  type        = string
  description = "Azure region for management resources."
  default     = "eastus2"
}

variable "environment" {
  type        = string
  description = "Environment tier."
  default     = "platform"
}

variable "log_retention_in_days" {
  type        = number
  description = "Retention period for Log Analytics Workspace in days (Enterprise standard is typically 365)."
  default     = 365
}

variable "alert_email" {
  type        = string
  description = "Email address for critical platform security and infrastructure alerts."
  default     = "secops@enterprise.internal"
}