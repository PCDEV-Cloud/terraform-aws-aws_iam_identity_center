data "aws_ssoadmin_instances" "this" {}

################################################################################
# Predefined Permission Sets
################################################################################

data "aws_iam_policy" "predefined" {
  for_each = local.predefined_permission_sets

  name = each.value["name"]
}

resource "aws_ssoadmin_permission_set" "predefined" {
  for_each = local.predefined_permission_sets

  instance_arn     = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  name             = each.value["name"]
  description      = each.value["description"]
  relay_state      = each.value["relay_state"]
  session_duration = each.value["session_duration"]
  tags             = each.value["tags"]
}

resource "aws_ssoadmin_managed_policy_attachment" "predefined" {
  for_each           = local.predefined_permission_sets
  instance_arn       = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  managed_policy_arn = data.aws_iam_policy.predefined[each.key].arn
  permission_set_arn = aws_ssoadmin_permission_set.predefined[each.key].arn
}

################################################################################
# Custom Permission Sets
################################################################################

resource "aws_iam_policy" "custom" {
  for_each = local.custom_permission_sets_2

  name        = format("%s_PermissionSet", each.value["name"])
  description = each.value["description"]
  policy      = each.value["policy"]
  tags        = each.value["tags"]
}

resource "aws_ssoadmin_permission_set" "custom" {
  for_each = local.custom_permission_sets_2

  instance_arn     = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  name             = each.value["name"]
  description      = each.value["description"]
  relay_state      = each.value["relay_state"]
  session_duration = each.value["session_duration"]
  tags             = each.value["tags"]
}

resource "aws_ssoadmin_customer_managed_policy_attachment" "custom" {
  for_each = local.custom_permission_sets_2

  instance_arn       = aws_ssoadmin_permission_set.custom[each.key].instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.custom[each.key].arn
  customer_managed_policy_reference {
    name = aws_iam_policy.custom[each.key].name
    path = "/"
  }
}