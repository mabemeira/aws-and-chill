output "role_name" {
  description = "The name of the EMR Studio service role"
  value       = aws_iam_role.emr_studio_service_role.name
}

output "role_arn" {
  description = "The ARN of the EMR Studio service role"
  value       = aws_iam_role.emr_studio_service_role.arn
}

output "policy_arn" {
  description = "The ARN of the service role policy"
  value       = aws_iam_policy.emr_studio_service_role_policy.arn
}