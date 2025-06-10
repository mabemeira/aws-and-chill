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

# Networking Module
module "networking" {
  source = "./modules/networking"
  
  vpc_id            = var.vpc_id
  subnet_ids        = var.subnet_ids
  emr_studio_name   = var.emr_studio_name
}

# EMR Studio Module
module "emr_studio" {
  source = "./modules/emr-studio"
  
  emr_studio_name             = var.emr_studio_name
  auth_mode                   = "IAM"
  vpc_id                      = module.networking.vpc_id
  subnet_ids                  = module.networking.subnet_ids
  service_role_arn            = module.emr_studio_service_role.role_arn
  workspace_security_group_id = module.networking.workspace_security_group_id
  engine_security_group_id    = module.networking.engine_security_group_id
  default_s3_location         = var.default_s3_location
  
  depends_on = [
    module.emr_studio_service_role,
    module.networking
  ]
}

# Service Catalog Module
module "service_catalog" {
  source = "./modules/service-catalog"
  
  portfolio_name       = var.service_catalog_portfolio_name
  portfolio_description = var.service_catalog_portfolio_description
  product_name         = var.service_catalog_product_name
  template_file_path   = "${path.module}/cloud-formation-templates/example-two-node-cluster.yaml"
  template_url         = "https://${var.emr_studio_bucket}.s3.amazonaws.com/service-catalog-templates/example-two-node-cluster.yaml"
  s3_bucket           = var.emr_studio_bucket
  
  tags = {
    Environment = "production"
    Project     = "aws-and-chill"
    Component   = "emr-studio"
  }
}
