output "permission_set_arns" {
  value = module.aws_iam_identity_center.permission_set_arns
}

output "permission_set_ids" {
  value = module.aws_iam_identity_center.permission_set_ids
}

output "user_ids" {
  value = module.aws_iam_identity_center.user_ids
}

output "group_ids" {
  value = module.aws_iam_identity_center.group_ids
}

output "instance_arn" {
  value = module.aws_iam_identity_center.instance_arn
}