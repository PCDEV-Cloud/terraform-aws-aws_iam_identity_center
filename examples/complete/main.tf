provider "aws" {
  region = "eu-west-1"
}

module "aws_iam_identity_center" {
  source = "../../"

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

  predefined_permission_sets = {
    administrator_access = {
      create = true
    }

    billing = {
      create           = true
      relay_state      = "https://eu-west-1.console.aws.amazon.com/billing/"
      session_duration = "PT2H"
    }
  }

  custom_permission_sets = [
    {
      name             = "DescribeEC2"
      description      = "This policy grants permissions to describe EC2 instances."
      relay_state      = "https://eu-west-1.console.aws.amazon.com/ec2/"
      session_duration = "PT2H"

      policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Action = [
              "ec2:Describe*",
            ]
            Effect   = "Allow"
            Resource = "*"
          },
        ]
      })

      tags = {}
    }
  ]

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