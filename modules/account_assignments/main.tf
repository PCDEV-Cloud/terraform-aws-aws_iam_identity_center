data "aws_ssoadmin_instances" "this" {}

################################################################################
# Permission Set ARNs
################################################################################

locals {
  list_of_permission_sets = flatten([for i in var.account_assignments : i.permission_sets])
  permission_set_arns     = { for i, k in data.aws_ssoadmin_permission_set.this : k.name => k.arn }
}

data "aws_ssoadmin_permission_set" "this" {
  count = length(local.list_of_permission_sets)

  instance_arn = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  name         = local.list_of_permission_sets[count.index]
}

################################################################################
# User IDs
################################################################################

locals {
  list_of_user_names = distinct(flatten([for i in var.account_assignments : i.usernames]))
  user_ids           = { for i, k in data.aws_identitystore_user.this : k.user_name => k.user_id }
}

data "aws_identitystore_user" "this" {
  count = length(local.list_of_user_names)

  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]

  alternate_identifier {
    unique_attribute {
      attribute_path  = "UserName"
      attribute_value = local.list_of_user_names[count.index]
    }
  }
}

################################################################################
# Group IDs
################################################################################

locals {
  list_of_groups = distinct(flatten([for i in var.account_assignments : i.groups]))
  group_ids      = { for i, k in data.aws_identitystore_group.this : k.display_name => k.group_id }
}

data "aws_identitystore_group" "this" {
  count = length(local.list_of_groups)

  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]

  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = local.list_of_groups[count.index]
    }
  }
}

################################################################################
# Account Assignments
################################################################################

locals {
  list_of_group_assignments = chunklist(flatten([for i in var.account_assignments : setproduct(i.account_ids, i.groups, i.permission_sets)]), 3)
  list_of_user_assignments  = chunklist(flatten([for i in var.account_assignments : setproduct(i.account_ids, i.usernames, i.permission_sets)]), 3)

  group_assignments = { for i, k in local.list_of_group_assignments : join("_", [k[0], k[1], k[2]]) => {
    account_id     = k[0]
    group          = k[1]
    permission_set = k[2]
  } }

  user_assignments = { for i, k in local.list_of_user_assignments : join("_", [k[0], k[1], k[2]]) => {
    account_id     = k[0]
    user_name      = k[1]
    permission_set = k[2]
  } }
}

resource "aws_ssoadmin_account_assignment" "user" {
  for_each = local.user_assignments

  instance_arn       = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  permission_set_arn = local.permission_set_arns[each.value["permission_set"]]

  principal_id   = local.user_ids[each.value["user_name"]]
  principal_type = "USER"

  target_id   = each.value["account_id"]
  target_type = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "group" { # Group Assignments
  for_each = local.group_assignments

  instance_arn       = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  permission_set_arn = local.permission_set_arns[each.value["permission_set"]]

  principal_id   = local.group_ids[each.value["group"]]
  principal_type = "GROUP"

  target_id   = each.value["account_id"]
  target_type = "AWS_ACCOUNT"
}