variable "portfolio_name" {
  description = "Name of the Service Catalog portfolio"
  type        = string
  default     = "EMR Cluster Templates"
}

variable "portfolio_description" {
  description = "Description of the Service Catalog portfolio"
  type        = string
  default     = "Portfolio containing EMR cluster templates for self-service provisioning"
}

variable "provider_name" {
  description = "Provider name for the Service Catalog portfolio"
  type        = string
  default     = "AWS and Chill Project"
}

variable "product_name" {
  description = "Name of the Service Catalog product"
  type        = string
  default     = "EMR Two Node Cluster"
}

variable "product_owner" {
  description = "Owner of the Service Catalog product"
  type        = string
  default     = "Data Team"
}

variable "template_version_name" {
  description = "Version name for the CloudFormation template"
  type        = string
  default     = "v1.0"
}

variable "template_description" {
  description = "Description of the CloudFormation template"
  type        = string
  default     = "Example two-node EMR cluster with Spark, Livy, JupyterEnterpriseGateway, and Hive"
}


variable "template_file_path" {
  description = "Local path to the CloudFormation template file"
  type        = string
}

variable "template_file_name" {
  description = "Name of the CloudFormation template file"
  type        = string
  default     = "example-two-node-cluster.yaml"
}

variable "s3_location_cloud_formation_templates" {
  description = "S3 bucket to store the CloudFormation template"
  type        = string
}

variable "tags" {
  description = "Tags to apply to Service Catalog resources"
  type        = map(string)
  default     = {}
}