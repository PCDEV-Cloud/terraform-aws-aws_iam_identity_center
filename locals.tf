################################################################################
# Predefined Permission Sets
################################################################################

locals {
  predefined_permission_sets = { for i, k in var.predefined_permission_sets : local.predefined_permission_set_definitions[i].name => merge(k, local.predefined_permission_set_definitions[i]) if k.create }

  predefined_permission_set_definitions = {
    administrator_access = {
      name        = "AdministratorAccess"
      description = "Provides full access to AWS services and resources."
    }
    billing = {
      name        = "Billing"
      description = "Grants permissions for billing and cost management. This includes viewing account usage and viewing and modifying budgets and payment methods."
    }
    database_administrator = {
      name        = "DatabaseAdministrator"
      description = "Grants full access permissions to AWS services and actions required to set up and configure AWS database services."
    }
    database_scientist = {
      name        = "DataScientist"
      description = "Grants permissions to AWS data analytics services."
    }
    network_administrator = {
      name        = "NetworkAdministrator"
      description = "Grants full access permissions to AWS services and actions required to set up and configure AWS network resources."
    }
    power_user_access = {
      name        = "PowerUserAccess"
      description = "Provides full access to AWS services and resources, but does not allow management of Users and groups."
    }
    read_only_access = {
      name        = "ReadOnlyAccess"
      description = "Provides read-only access to AWS services and resources."
    }
    security_audit = {
      name        = "SecurityAudit"
      description = "The security audit template grants access to read security configuration metadata. It is useful for software that audits the configuration of an AWS account."
    }
    support_user = {
      name        = "SupportUser"
      description = "This policy grants permissions to troubleshoot and resolve issues in an AWS account. This policy also enables the user to contact AWS support to create and manage cases."
    }
    system_administrator = {
      name        = "SystemAdministrator"
      description = "Grants full access permissions necessary for resources required for application and development operations."
    }
    view_only_access = {
      name        = "ViewOnlyAccess"
      description = "This policy grants permissions to view resources and basic metadata across all AWS services."
    }
  }
}

################################################################################
# Custom Permission Sets
################################################################################

locals {
  custom_permission_sets_2 = { for i in var.custom_permission_sets : i.name => i }
}