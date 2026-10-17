variable "root_mg_display_name" {
  type        = string
  description = "Display name for the root enterprise management group."
  default     = "Enterprise-Root"
}

variable "prefix" {
  type        = string
  description = "Prefix for management group IDs."
  default     = "ent"
}