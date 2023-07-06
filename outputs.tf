output "permission_set_arns" {
  value = merge(
    { for i, k in aws_ssoadmin_permission_set.predefined : i => k.arn },
    { for i, k in aws_ssoadmin_permission_set.custom : i => k.arn }
  )
  description = "A map of permission set ARNs."
}

output "permission_set_ids" {
  value = merge(
    { for i, k in aws_ssoadmin_permission_set.predefined : i => k.id },
    { for i, k in aws_ssoadmin_permission_set.custom : i => k.id }
  )
  description = "A map of permission set IDs."
}