# Service Catalog Portfolio
resource "aws_servicecatalog_portfolio" "emr_templates" {
  name          = var.portfolio_name
  description   = var.portfolio_description
  provider_name = var.provider_name

  tags = merge(
    var.tags,
    {
      Name    = var.portfolio_name
      Project = "aws-and-chill"
      Team    = "Data Analytics"
    }
  )
}

# Service Catalog Product
resource "aws_servicecatalog_product" "emr_cluster_template" {
  name  = var.product_name
  owner = var.product_owner
  type  = "CLOUD_FORMATION_TEMPLATE"

  provisioning_artifact_parameters {
    name         = var.template_version_name
    description  = var.template_description
    template_url = "https://${aws_s3_object.cloudformation_template.bucket}.s3.amazonaws.com/${aws_s3_object.cloudformation_template.key}"
    type         = "CLOUD_FORMATION_TEMPLATE"
  }

  tags = merge(
    var.tags,
    {
      Name    = var.product_name
      Project = "aws-and-chill"
      Team    = "Data Analytics"
    }
  )
}

# Associate Product with Portfolio
resource "aws_servicecatalog_product_portfolio_association" "emr_template_association" {
  portfolio_id = aws_servicecatalog_portfolio.emr_templates.id
  product_id   = aws_servicecatalog_product.emr_cluster_template.id
}

# Upload CloudFormation template to S3 for Service Catalog
resource "aws_s3_object" "cloudformation_template" {
  bucket = split("/", replace(var.s3_location_cloud_formation_templates, "s3://", ""))[0]
  key    = "${trimsuffix(join("/", slice(split("/", replace(var.s3_location_cloud_formation_templates, "s3://", "")), 1, length(split("/", replace(var.s3_location_cloud_formation_templates, "s3://", ""))))), "/")}/${var.template_file_name}"
  source = var.template_file_path
  etag   = filemd5(var.template_file_path)

  tags = var.tags
}