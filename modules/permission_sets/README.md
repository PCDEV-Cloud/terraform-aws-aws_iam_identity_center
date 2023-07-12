# permission_sets

## Usage

```hcl
module "permission_sets" {
  source = "github.com/PCDEV-Cloud/terraform-aws-aws_iam_identity_center//modules/permission_sets"

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
}
```