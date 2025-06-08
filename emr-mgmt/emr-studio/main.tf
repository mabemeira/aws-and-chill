variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

provider "aws" {
  region = var.aws_region
}

data "aws_caller_identity" "current" {}

variable "emr_studio_service_role" {
  description = "EMR Studio Service Role name"
  type        = string
  default     = "EMRStudio-Service-Role"
}

variable "emr_studio_bucket" {
  description = "S3 bucket for EMR Studio notebooks"
  type        = string
}

resource "aws_iam_policy" "admin_user_policy" {
  name = "emr-mgmt-emr-studio-admin-user"
  policy = templatefile("policies/admin_user_permissions.json", {
    region             = var.aws_region
    aws-account-id     = data.aws_caller_identity.current.account_id
    EMRStudio-Service-Role = var.emr_studio_service_role
  })
}

resource "aws_iam_user" "admin_user" {
  name = "emr-mgmt-emr-studio-admin-user"
}

resource "aws_iam_user_policy_attachment" "emr_mgmt_emr_studio_admin_user_attach_policy" {
  user       = aws_iam_user.admin_user.name
  policy_arn = aws_iam_policy.admin_user_policy.arn
}

resource "aws_iam_role" "emr_studio_service_role" {
  name = var.emr_studio_service_role
  assume_role_policy = templatefile("policies/service_role_trust_policy.json", {
    region         = var.aws_region
    aws-account-id = data.aws_caller_identity.current.account_id
  })
}

resource "aws_iam_policy" "emr_studio_service_role_policy" {
  name = "emr-studio-service-role-permissions"
  policy = templatefile("policies/service_role_permissions.json", {
    bucket-name = var.emr_studio_bucket
  })
}

resource "aws_iam_role_policy_attachment" "emr_studio_service_role_attach_policy" {
  role       = aws_iam_role.emr_studio_service_role.name
  policy_arn = aws_iam_policy.emr_studio_service_role_policy.arn
}
