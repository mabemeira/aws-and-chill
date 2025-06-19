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