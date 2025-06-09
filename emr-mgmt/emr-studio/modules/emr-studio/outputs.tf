output "emr_studio_id" {
  description = "EMR Studio ID"
  value       = aws_emr_studio.main.id
}

output "emr_studio_name" {
  description = "EMR Studio name"
  value       = aws_emr_studio.main.name
}

output "emr_studio_arn" {
  description = "EMR Studio ARN"
  value       = aws_emr_studio.main.arn
}

output "emr_studio_url" {
  description = "EMR Studio URL"
  value       = aws_emr_studio.main.url
}

output "service_role" {
  description = "EMR Studio service role ARN"
  value       = aws_emr_studio.main.service_role
}


output "emr_studio_details" {
  description = "Complete EMR Studio details"
  value = {
    id           = aws_emr_studio.main.id
    name         = aws_emr_studio.main.name
    arn          = aws_emr_studio.main.arn
    url          = aws_emr_studio.main.url
    service_role = aws_emr_studio.main.service_role
  }
}