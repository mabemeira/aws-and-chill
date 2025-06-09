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

# EMR Studio Configuration Variables
variable "emr_studio_name" {
  description = "Name for the EMR Studio"
  type        = string
  default     = "aws-and-chill-emr-studio"
}

variable "vpc_id" {
  description = "VPC ID where EMR Studio will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for EMR Studio"
  type        = list(string)
  
  validation {
    condition     = length(var.subnet_ids) >= 1
    error_message = "At least one subnet ID must be provided."
  }
}

variable "default_s3_location" {
  description = "Default S3 location for EMR Studio"
  type        = string
}