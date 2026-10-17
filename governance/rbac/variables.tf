variable "platform_mg_id" {
  type        = string
  description = "Resource ID of the Platform Management Group."
  default     = "/providers/Microsoft.Management/managementGroups/ent-platform"
}

variable "network_admin_group_name" {
  type        = string
  description = "Display name of the Entra ID group for Network Administrators."
  default     = "SG-Azure-NetworkAdmins"
}

variable "security_admin_group_name" {
  type        = string
  description = "Display name of the Entra ID group for Security Administrators."
  default     = "SG-Azure-SecurityAdmins"
}