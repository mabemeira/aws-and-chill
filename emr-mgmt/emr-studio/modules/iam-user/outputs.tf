output "user_name" {
  description = "The name of the IAM user"
  value       = aws_iam_user.user.name
}

output "user_arn" {
  description = "The ARN of the IAM user"
  value       = aws_iam_user.user.arn
}

output "policy_arn" {
  description = "The ARN of the IAM policy"
  value       = aws_iam_policy.user_policy.arn
}