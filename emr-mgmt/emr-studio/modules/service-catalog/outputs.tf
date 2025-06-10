output "portfolio_id" {
  description = "ID of the Service Catalog portfolio"
  value       = aws_servicecatalog_portfolio.emr_templates.id
}

output "portfolio_arn" {
  description = "ARN of the Service Catalog portfolio"
  value       = aws_servicecatalog_portfolio.emr_templates.arn
}

output "product_id" {
  description = "ID of the Service Catalog product"
  value       = aws_servicecatalog_product.emr_cluster_template.id
}

output "product_arn" {
  description = "ARN of the Service Catalog product"
  value       = aws_servicecatalog_product.emr_cluster_template.arn
}

output "template_s3_url" {
  description = "S3 URL of the uploaded CloudFormation template"
  value       = "https://${var.s3_bucket}.s3.amazonaws.com/${aws_s3_object.cloudformation_template.key}"
}