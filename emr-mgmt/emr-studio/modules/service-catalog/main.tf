# Service Catalog Portfolio
resource "aws_servicecatalog_portfolio" "emr_templates" {
  name          = var.portfolio_name
  description   = var.portfolio_description
  provider_name = var.provider_name

  tags = var.tags
}

# Service Catalog Product
resource "aws_servicecatalog_product" "emr_cluster_template" {
  name  = var.product_name
  owner = var.product_owner
  type  = "CLOUD_FORMATION_TEMPLATE"

  provisioning_artifact_parameters {
    name         = var.template_version_name
    description  = var.template_description
    template_url = var.template_url
    type         = "CLOUD_FORMATION_TEMPLATE"
  }

  tags = var.tags
}

# Associate Product with Portfolio
resource "aws_servicecatalog_product_portfolio_association" "emr_template_association" {
  portfolio_id = aws_servicecatalog_portfolio.emr_templates.id
  product_id   = aws_servicecatalog_product.emr_cluster_template.id
}

# Upload CloudFormation template to S3 for Service Catalog
resource "aws_s3_object" "cloudformation_template" {
  bucket = var.s3_bucket
  key    = "service-catalog-templates/${var.template_file_name}"
  source = var.template_file_path
  etag   = filemd5(var.template_file_path)

  tags = var.tags
}