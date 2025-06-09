variable "service_role_name" {
  description = "Name of the EMR Studio service role"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
}

variable "emr_studio_bucket" {
  description = "EMR Studio S3 bucket name"
  type        = string
}

resource "aws_iam_role" "emr_studio_service_role" {
  name = var.service_role_name
  assume_role_policy = templatefile("${path.root}/policies/service_role_trust_policy.json", {
    region         = var.aws_region
    aws-account-id = var.aws_account_id
  })

  tags = {
    Name    = var.service_role_name
    Project = "aws-and-chill"
  }
}

resource "aws_iam_policy" "emr_studio_service_role_policy" {
  name = "emr-studio-service-role-permissions"
  policy = templatefile("${path.root}/policies/service_role_permissions.json", {
    bucket-name = var.emr_studio_bucket
  })

  tags = {
    Name    = "emr-studio-service-role-permissions"
    Project = "aws-and-chill"
  }
}

resource "aws_iam_role_policy_attachment" "emr_studio_service_role_attach_policy" {
  role       = aws_iam_role.emr_studio_service_role.name
  policy_arn = aws_iam_policy.emr_studio_service_role_policy.arn
}