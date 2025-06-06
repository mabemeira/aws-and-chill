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

resource "aws_iam_policy" "admin_policy" {
  name = "emr-mgmt-emr-studio-admin"
  policy = templatefile("policies/admin_permissions.json", {
    region             = var.aws_region
    aws-account-id     = data.aws_caller_identity.current.account_id
    EMRStudio-Service-Role = var.emr_studio_service_role
  })
}

resource "aws_iam_user" "admin_user" {
  name = "emr-mgmt-emr-studio-admin"
}

resource "aws_iam_user_policy_attachment" "emr_mgmt_emr_studio_admin_attach_policy" {
  user       = aws_iam_user.admin_user.name
  policy_arn = aws_iam_policy.admin_policy.arn
}
