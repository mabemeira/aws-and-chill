variable "vpc_id" {
  description = "VPC ID where EMR Studio will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for EMR Studio"
  type        = list(string)
}

variable "emr_studio_name" {
  description = "Name for the EMR Studio (used for resource naming)"
  type        = string
}