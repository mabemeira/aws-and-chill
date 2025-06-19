variable "user_level" {
  description = "The level of the user (admin, basic, intermediate, advanced)"
  type        = string
  
  validation {
    condition     = contains(["admin", "basic", "intermediate", "advanced"], var.user_level)
    error_message = "User level must be one of: admin, basic, intermediate, advanced."
  }
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
}

variable "emr_studio_service_role" {
  description = "EMR Studio service role name"
  type        = string
}

variable "virtual_cluster_id" {
  description = "EMR virtual cluster ID for EKS"
  type        = string
  default     = "*"
}

variable "emr_on_eks_execution_role" {
  description = "EMR on EKS execution role name"
  type        = string
  default     = "*"
}