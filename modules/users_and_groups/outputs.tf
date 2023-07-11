################################################################################
# Users
################################################################################

output "user_ids" {
  value = { for i, k in aws_identitystore_user.this : i => k.user_id }
}

################################################################################
# Groups
################################################################################

output "group_ids" {
  value = { for i, k in aws_identitystore_group.this : i => k.group_id }
}