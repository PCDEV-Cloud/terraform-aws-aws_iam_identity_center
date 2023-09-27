output "permission_set_arns" {
  value       = module.permission_sets.permission_set_arns
  description = "A map of permission set ARNs."
}

output "permission_set_ids" {
  value       = module.permission_sets.permission_set_ids
  description = "A map of permission set IDs."
}

output "user_ids" {
  value       = module.users_and_groups.user_ids
  description = "A map of user IDs."
}

output "group_ids" {
  value       = module.users_and_groups.group_ids
  description = "A map of group IDs."
}

output "instance_arn" {
  value       = data.aws_ssoadmin_instances.this.identity_store_ids[0]
  description = "An IAM Identity Center instance ARN."
}