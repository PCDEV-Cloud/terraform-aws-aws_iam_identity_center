data "aws_ssoadmin_instances" "this" {}

################################################################################
# Users
################################################################################

locals {
  users = { for i in var.users : i.username => i }
}

data "aws_identitystore_user" "this" { # External Identity Provider
  for_each = var.settings.external_identity_provider ? local.users : {}

  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]

  alternate_identifier {
    unique_attribute {
      attribute_path  = "UserName"
      attribute_value = each.value["username"]
    }
  }
}

resource "aws_identitystore_user" "this" { # Identity Center Directory
  for_each = var.settings.external_identity_provider ? {} : local.users

  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
  display_name      = coalesce(each.value["display_name"], join(" ", [each.value["first_name"], each.value["last_name"]]))
  user_name         = each.value["username"]

  name {
    given_name  = each.value["first_name"]
    family_name = each.value["last_name"]
  }
}

################################################################################
# Groups
################################################################################

locals {
  groups = { for i in var.groups : i.display_name => i }
}

data "aws_identitystore_group" "this" { # External Identity Provider
  for_each = var.settings.external_identity_provider ? local.groups : {}

  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]

  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = each.value["display_name"]
    }
  }
}

resource "aws_identitystore_group" "this" { # Identity Center Directory
  for_each = var.settings.external_identity_provider ? {} : local.groups

  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
  display_name      = each.value["display_name"]
  description       = each.value["description"]
}

################################################################################
# Membership
################################################################################

locals {
  user_group_memberships = flatten([for i in var.users : [for k in i.group_membership : {
    group    = k
    username = i.username
  }]])

  group_members = flatten([for i in var.groups : [for k in i.members : {
    group    = i.display_name
    username = k
  }]])

  list_of_all_group_memberships = distinct(concat(local.user_group_memberships, local.group_members))
  all_group_memberships         = { for i, k in local.list_of_all_group_memberships : join("_", [k.username, k.group]) => k }
}

resource "aws_identitystore_group_membership" "this" { # Identity Center Directory
  for_each = var.settings.external_identity_provider ? {} : local.all_group_memberships

  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
  group_id          = aws_identitystore_group.this[each.value["group"]].group_id
  member_id         = aws_identitystore_user.this[each.value["username"]].user_id
}