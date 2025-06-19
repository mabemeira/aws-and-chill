
locals {
  policy_files = {
    admin        = "admin_user_permissions.json"
    basic        = "basic_level_user_permissions.json"
    intermediate = "intermediate_level_user_permissions.json"
    advanced     = "advanced_level_user_permissions.json"
  }
}

resource "aws_iam_policy" "user_policy" {
  name = "emr-mgmt-emr-studio-${var.user_level}-user-policy"
  policy = templatefile("${path.root}/policies/${local.policy_files[var.user_level]}", merge(
    {
      region                  = var.aws_region
      aws-account-id          = var.aws_account_id
      emr-studio-service-role = var.emr_studio_service_role
    },
    contains(["intermediate", "advanced"], var.user_level) ? {
      virtual-cluster-id        = var.virtual_cluster_id
      emr-on-eks-execution-role = var.emr_on_eks_execution_role
    } : {}
  ))

  tags = {
    Name    = "emr-mgmt-emr-studio-${var.user_level}-user-policy"
    Project = "aws-and-chill"
  }
}

resource "aws_iam_user" "user" {
  name = "emr-mgmt-emr-studio-${var.user_level}-user"

  tags = {
    Name    = "emr-mgmt-emr-studio-${var.user_level}-user"
    Project = "aws-and-chill"
  }
}

resource "aws_iam_user_policy_attachment" "user_attach_policy" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.user_policy.arn
}