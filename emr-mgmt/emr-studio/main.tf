provider "aws" {
  region = var.aws_region
}

data "aws_caller_identity" "current" {}

# Admin User
module "admin_user" {
  source = "./modules/iam-user"
  
  user_level                 = "admin"
  aws_region                 = var.aws_region
  aws_account_id             = data.aws_caller_identity.current.account_id
  emr_studio_service_role    = var.emr_studio_service_role
  virtual_cluster_id         = var.virtual_cluster_id
  emr_on_eks_execution_role  = var.emr_on_eks_execution_role
}

# EMR Studio Service Role
module "emr_studio_service_role" {
  source = "./modules/emr-service-role"
  
  service_role_name  = var.emr_studio_service_role
  aws_region         = var.aws_region
  aws_account_id     = data.aws_caller_identity.current.account_id
  emr_studio_bucket  = var.emr_studio_bucket
}

# Basic User
module "basic_user" {
  source = "./modules/iam-user"
  
  user_level                 = "basic"
  aws_region                 = var.aws_region
  aws_account_id             = data.aws_caller_identity.current.account_id
  emr_studio_service_role    = var.emr_studio_service_role
  virtual_cluster_id         = var.virtual_cluster_id
  emr_on_eks_execution_role  = var.emr_on_eks_execution_role
}

# Intermediate User
module "intermediate_user" {
  source = "./modules/iam-user"
  
  user_level                 = "intermediate"
  aws_region                 = var.aws_region
  aws_account_id             = data.aws_caller_identity.current.account_id
  emr_studio_service_role    = var.emr_studio_service_role
  virtual_cluster_id         = var.virtual_cluster_id
  emr_on_eks_execution_role  = var.emr_on_eks_execution_role
}

# Advanced User
module "advanced_user" {
  source = "./modules/iam-user"
  
  user_level                 = "advanced"
  aws_region                 = var.aws_region
  aws_account_id             = data.aws_caller_identity.current.account_id
  emr_studio_service_role    = var.emr_studio_service_role
  virtual_cluster_id         = var.virtual_cluster_id
  emr_on_eks_execution_role  = var.emr_on_eks_execution_role
}

# Outputs
output "emr_studio_service_role" {
  description = "EMR Studio service role details"
  value = {
    name       = module.emr_studio_service_role.role_name
    arn        = module.emr_studio_service_role.role_arn
    policy_arn = module.emr_studio_service_role.policy_arn
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