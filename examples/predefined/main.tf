provider "aws" {
  region = "eu-west-1"
}

module "aws_iam_identity_center" {
  source = "../../"

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