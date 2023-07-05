provider "aws" {
  region = "eu-west-1"
}

module aws_iam_identity_center {
  source = "../../"

  permission_sets = {
    "AdministratorAccess" = {
      session_duration          = "PT1H"
      predefined_permission_set = "AdministratorAccess"
    }
    
    "Billing" = {
      session_duration          = "PT1H"
      predefined_permission_set = "Billing"
    }

    "ViewOnlyAccess" = {
      session_duration          = "PT1H"
      predefined_permission_set = "ViewOnlyAccess"
    }
  }
}