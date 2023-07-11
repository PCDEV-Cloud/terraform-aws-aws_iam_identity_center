variable "account_assignments" {
  type = list(object({
    account_ids     = list(string)
    usernames       = optional(list(string), [])
    groups          = optional(list(string), [])
    permission_sets = list(string)
  }))
  default     = []
  description = ""
}