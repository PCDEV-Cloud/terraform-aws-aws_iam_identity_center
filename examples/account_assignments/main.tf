provider "aws" {
  region = "eu-west-1"
}

module "account_assignments" {
  source = "../../modules/account_assignments"

  account_assignments = [
    {
      account_ids     = ["140679301063"]
      usernames       = ["john.doe"]
      permission_sets = ["AdministratorAccess"]
    },
    {
      account_ids     = ["140679301063"]
      usernames       = ["john.doe", "john.doe2"]
      groups          = ["Group1", "Group2"]
      permission_sets = ["DescribeEC2"]
    }
  ]
}