variable "predefined_permission_sets" {
  type = map(object(
    {
      create           = optional(bool, false)
      relay_state      = optional(string)
      session_duration = optional(string)
      tags             = optional(map(string))
    }
  ))
  default     = {}
  description = "A map of predefined permission sets to be created in the organization. Available permission sets are 'administrator_access', 'billing', 'database_administrator', 'database_scientist', 'network_administrator', 'power_user_access', 'read_only_access', 'security_audit', 'support_user', 'system_administrator' and 'view_only_access'."

  validation {
    condition     = alltrue([for i, k in var.predefined_permission_sets : contains(["administrator_access", "billing", "database_administrator", "database_scientist", "network_administrator", "power_user_access", "read_only_access", "security_audit", "support_user", "system_administrator", "view_only_access"], i)])
    error_message = "The object in the \"predefined_permission_sets\" must be the \"administrator_access\", \"billing\", \"database_administrator\", \"database_scientist\", \"network_administrator\", \"power_user_access\", \"read_only_access\", \"security_audit\", \"support_user\", \"system_administrator\" or \"view_only_access\"."
  }
}

variable "custom_permission_sets" {
  type = list(object({
    name             = string
    policy           = string
    description      = optional(string)
    relay_state      = optional(string)
    session_duration = optional(string)
    tags             = optional(map(string))
  }))
  default     = []
  description = "A list of permission sets to be created in the organization."

  validation {
    condition     = alltrue([for i in var.custom_permission_sets : can(jsondecode(i.policy))])
    error_message = "The given value for the \"policy\" attribute is not suitable. The value must be valid a JSON code."
  }
}