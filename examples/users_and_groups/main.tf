provider "aws" {
  region = "eu-west-1"
}

module "users_and_groups" {
  source = "../../modules/users_and_groups"

  users = [
    {
      display_name = "John Doe"
      username     = "john.doe"
      first_name   = "John"
      last_name    = "Doe"

      group_membership = [
        "Group1"
      ]
    },
    {
      display_name = "John Doe"
      username     = "john.doe2"
      first_name   = "John"
      last_name    = "Doe"
    }
  ]

  groups = [
    {
      display_name = "Group1"
      description  = "description"
    },
    {
      display_name = "Group2"
      description  = "description"

      members = [
        "john.doe",
        "john.doe2"
      ]
    }
  ]
}

output "user_ids" {
  value = module.users_and_groups.user_ids
}

output "group_ids" {
  value = module.users_and_groups.group_ids
}