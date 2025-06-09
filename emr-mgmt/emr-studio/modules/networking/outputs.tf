output "vpc_id" {
  description = "VPC ID"
  value       = data.aws_vpc.selected.id
}

output "subnet_ids" {
  description = "List of subnet IDs"
  value       = data.aws_subnets.selected.ids
}

output "workspace_security_group_id" {
  description = "Security group ID for EMR Studio workspace"
  value       = aws_security_group.emr_studio_workspace.id
}

output "engine_security_group_id" {
  description = "Security group ID for EMR Studio engine"
  value       = aws_security_group.emr_studio_engine.id
}

output "workspace_security_group_arn" {
  description = "Security group ARN for EMR Studio workspace"
  value       = aws_security_group.emr_studio_workspace.arn
}

output "engine_security_group_arn" {
  description = "Security group ARN for EMR Studio engine"
  value       = aws_security_group.emr_studio_engine.arn
}