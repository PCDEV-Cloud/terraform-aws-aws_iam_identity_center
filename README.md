# AWS IAM Identity Center Terraform module

## Usage

```hcl
module aws_iam_identity_center {
  source = "github.com/PCDEV-Cloud/terraform-aws-aws_iam_identity_center"

  # Configuration options
}
```

## Examples
### Create an 'AdministratorAccess' and 'Billing' predefined permission sets
```hcl
module aws_iam_identity_center {
  source = "github.com/PCDEV-Cloud/terraform-aws-aws_iam_identity_center"

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
}
```

### Create a custom permission set with permission to describe EC2 instances
```hcl
module aws_iam_identity_center {
  source = "github.com/PCDEV-Cloud/terraform-aws-aws_iam_identity_center"

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
    }
  ]
}
```