################################################################################
# Users
################################################################################

output "user_ids" {
  value       = { for i, k in aws_identitystore_user.this : i => k.user_id }
  description = "A map of user IDs."
}

################################################################################
# Groups
################################################################################

output "group_ids" {
  value       = { for i, k in aws_identitystore_group.this : i => k.group_id }
  description = "A map of group IDs."
}