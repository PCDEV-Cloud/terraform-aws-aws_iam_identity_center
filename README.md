# AWS IAM Identity Center Terraform module

## Requirements
1. AWS Organization must be created. For details on creating AWS Organization, see [Creating and configuring an organization](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_tutorials_basic.html#tutorial-orgs-step1) tutorial.
2. SSO authentication must be enabled within IAM Identity Center. For details on enabling SSO authentication, see [Getting Started](https://docs.aws.amazon.com/singlesignon/latest/userguide/getting-started.html) in the AWS IAM Identity Center (successor to AWS Single Sign-On) User Guide.

## Features
1. Create users and groups with cross-account access in AWS IAM Identity Center.
2. Create permission sets from a list of predefined ones or with your own custom policies.
3. Assign users and groups to AWS accounts with appropriate permission sets. If an external provider is set, it is not necessary to create users and groups with the `users_and_groups` submodule.

## Usage

```hcl
module "aws_iam_identity_center" {
  source = "github.com/PCDEV-Cloud/terraform-aws-aws_iam_identity_center"

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
      description  = "This is 1st group."
    },
    {
      display_name = "Group2"
      description  = "This is 2nd group."

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
      account_ids     = ["123456789012"]
      usernames       = ["john.doe"]
      permission_sets = ["AdministratorAccess"]
    },
    {
      account_ids     = ["123456789012"]
      usernames       = ["john.doe", "john.doe2"]
      groups          = ["Group1", "Group2"]
      permission_sets = ["DescribeEC2"]
    }
  ]
}
```