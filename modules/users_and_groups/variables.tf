variable "settings" {
  type = object({
    external_identity_provider = optional(bool, false)
  })
  default     = {}
  description = ""
}

################################################################################
# Users
################################################################################

variable "users" {
  type = list(object({
    display_name     = optional(string)
    username         = string
    first_name       = string
    last_name        = string
    group_membership = optional(list(string), [])
  }))
  default     = []
  description = "A list of users to be created in the Identity Center directory."
}

################################################################################
# Groups
################################################################################

variable "groups" {
  type = list(object({
    display_name = string
    description  = optional(string)
    members      = optional(list(string), [])
  }))
  default     = []
  description = "A list of groups to be created in the Identity Center directory."
}