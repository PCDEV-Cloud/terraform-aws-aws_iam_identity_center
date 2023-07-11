variable "users" {
  type = list(object({
    display_name     = optional(string)
    username         = string
    first_name       = string
    last_name        = string
    group_membership = optional(list(string))
  }))
  default     = []
  description = "A list of users to be created in the Identity Center directory."
}

variable "groups" {
  type = list(object({
    display_name = string
    description  = optional(string)
    members      = optional(list(string))
  }))
  default     = []
  description = "A list of groups to be created in the Identity Center directory."
}

variable "predefined_permission_sets" {
  type = map(object(
    {
      create           = optional(bool)
      relay_state      = optional(string)
      session_duration = optional(string)
      tags             = optional(map(string))
    }
  ))
  default     = {}
  description = "A map of predefined permission sets to be created in the organization. Available permission sets are 'administrator_access', 'billing', 'database_administrator', 'database_scientist', 'network_administrator', 'power_user_access', 'read_only_access', 'security_audit', 'support_user', 'system_administrator' and 'view_only_access'."
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
}

variable "account_assignments" {
  type = list(object({
    account_ids     = list(string)
    usernames       = optional(list(string))
    groups          = optional(list(string))
    permission_sets = list(string)
  }))
  default     = []
  description = ""
}