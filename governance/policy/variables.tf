variable "root_management_group_id" {
  type        = string
  description = "Resource ID of the Enterprise Root Management Group."
  default     = "/providers/Microsoft.Management/managementGroups/your-tenant-id-here"
}

variable "allowed_locations" {
  type        = list(string)
  description = "List of approved Azure regions for resource deployment."
  default     = ["eastus2", "centralus"]
}