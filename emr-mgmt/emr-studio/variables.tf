variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "emr_studio_service_role" {
  description = "EMR Studio Service Role name"
  type        = string
  default     = "EMRStudio-Service-Role"
}

variable "emr_studio_bucket" {
  description = "S3 bucket for EMR Studio notebooks"
  type        = string
}