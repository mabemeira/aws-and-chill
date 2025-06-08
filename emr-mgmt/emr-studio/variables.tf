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

variable "virtual_cluster_id" {
  description = "EMR virtual cluster ID for EKS (use '*' for all clusters)"
  type        = string
  default     = "*"
}

variable "emr_on_eks_execution_role" {
  description = "EMR on EKS execution role name (use '*' for all roles)"
  type        = string
  default     = "*"
}