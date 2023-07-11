data "aws_ssoadmin_instances" "this" {}

################################################################################
# Users and Groups
################################################################################

module "users_and_groups" {
  source = "./modules/users_and_groups"

  users  = var.users
  groups = var.groups
}

################################################################################
# Permission Sets
################################################################################

module "permission_sets" {
  source = "./modules/permission_sets"

  predefined_permission_sets = var.predefined_permission_sets
  custom_permission_sets     = var.custom_permission_sets
}

################################################################################
# Account Assignments
################################################################################

module "account_assignments" {
  source = "./modules/account_assignments"

  account_assignments = var.account_assignments

  depends_on = [
    module.users_and_groups,
    module.permission_sets
  ]
}