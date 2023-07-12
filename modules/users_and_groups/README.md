# users_and_groups

## Usage

```hcl
module "users_and_groups" {
  source = "github.com/PCDEV-Cloud/terraform-aws-aws_iam_identity_center//modules/users_and_groups"

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
```