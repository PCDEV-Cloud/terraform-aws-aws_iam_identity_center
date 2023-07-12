# account_assignments

## Usage

```hcl
module "account_assignments" {
  source = "github.com/PCDEV-Cloud/terraform-aws-aws_iam_identity_center//modules/account_assignments"

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