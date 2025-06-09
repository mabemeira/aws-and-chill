output "emr_studio_service_role" {
  description = "EMR Studio service role details"
  value = {
    name       = module.emr_studio_service_role.role_name
    arn        = module.emr_studio_service_role.role_arn
    policy_arn = module.emr_studio_service_role.policy_arn
  }
}

output "emr_studio" {
  description = "EMR Studio details"
  value       = module.emr_studio.emr_studio_details
}

output "networking" {
  description = "Networking details"
  value = {
    vpc_id                      = module.networking.vpc_id
    subnet_ids                  = module.networking.subnet_ids
    workspace_security_group_id = module.networking.workspace_security_group_id
    engine_security_group_id    = module.networking.engine_security_group_id
  }
}

output "iam_users" {
  description = "IAM users created for different access levels"
  value = {
    admin = {
      name       = module.admin_user.user_name
      arn        = module.admin_user.user_arn
      policy_arn = module.admin_user.policy_arn
    }
    basic = {
      name       = module.basic_user.user_name
      arn        = module.basic_user.user_arn
      policy_arn = module.basic_user.policy_arn
    }
    intermediate = {
      name       = module.intermediate_user.user_name
      arn        = module.intermediate_user.user_arn
      policy_arn = module.intermediate_user.policy_arn
    }
    advanced = {
      name       = module.advanced_user.user_name
      arn        = module.advanced_user.user_arn
      policy_arn = module.advanced_user.policy_arn
    }
  }
}