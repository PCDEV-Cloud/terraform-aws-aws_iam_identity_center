# AWS IAM Identity Center Terraform module

## Usage

```hcl
module aws_iam_identity_provider {
  source = "github.com/PCDEV-Cloud/terraform-aws-aws_iam_identity_center"

  # Configuration options
}
```

## Examples
### Create an 'AdministratorAccess' predefined permission set
```hcl
module aws_iam_identity_provider {
  source = "git::ssh://git@bitbucket.org/thesoftwarehouse/terraform-modules-bis.git//aws_iam_identity_provider"

  permission_sets = {
    "AdministratorAccess" = {
      session_duration          = "PT1H"
      predefined_permission_set = "AdministratorAccess"
    }
  }
}
```

### Create a custom permission set with permission to describe EC2 instances
```hcl
module aws_iam_identity_provider {
  source = "git::ssh://git@bitbucket.org/thesoftwarehouse/terraform-modules-bis.git//aws_iam_identity_provider"

  permission_sets = {
    "DescribeEC2" = {
      session_duration = "PT2H"
      relay_state      = "https://eu-central-1.console.aws.amazon.com/ec2/"
      description      = "This policy grants permissions to describe EC2 instances."

      custom_permission_set = jsonencode({
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
  }
}
```