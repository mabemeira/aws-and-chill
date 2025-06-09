variable "emr_studio_name" {
  description = "Name for the EMR Studio"
  type        = string
}

variable "auth_mode" {
  description = "Authentication mode for EMR Studio"
  type        = string
  default     = "IAM"
  
  validation {
    condition     = contains(["IAM", "SSO"], var.auth_mode)
    error_message = "Auth mode must be either IAM or SSO."
  }
}

variable "vpc_id" {
  description = "VPC ID where EMR Studio will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for EMR Studio"
  type        = list(string)
}

variable "service_role_arn" {
  description = "ARN of the service role for EMR Studio"
  type        = string
}


variable "workspace_security_group_id" {
  description = "Security group ID for EMR Studio workspace"
  type        = string
}

variable "engine_security_group_id" {
  description = "Security group ID for EMR Studio engine"
  type        = string
}

variable "default_s3_location" {
  description = "Default S3 location for EMR Studio"
  type        = string
}


variable "tags" {
  description = "Additional tags for EMR Studio"
  type        = map(string)
  default     = {}
}

# EMR Studio
resource "aws_emr_studio" "main" {
  name                        = var.emr_studio_name
  auth_mode                   = var.auth_mode
  vpc_id                      = var.vpc_id
  subnet_ids                  = var.subnet_ids
  service_role                = var.service_role_arn
  workspace_security_group_id = var.workspace_security_group_id
  engine_security_group_id    = var.engine_security_group_id
  default_s3_location         = var.default_s3_location


  tags = merge(
    var.tags,
    {
      Name    = var.emr_studio_name
      Project = "aws-and-chill"
    }
  )
}