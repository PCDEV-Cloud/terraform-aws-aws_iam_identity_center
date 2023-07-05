provider "aws" {
  region = "eu-west-1"
}

module "aws_iam_identity_center" {
  source = "../../"

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