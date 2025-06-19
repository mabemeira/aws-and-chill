
resource "aws_iam_role" "emr_studio_service_role" {
  name = var.service_role_name
  assume_role_policy = templatefile("${path.root}/policies/service_role_trust_policy.json", {
    region         = var.aws_region
    aws-account-id = var.aws_account_id
  })

  tags = {
    Name    = var.service_role_name
    Project = "aws-and-chill"
  }
}

resource "aws_iam_policy" "emr_studio_service_role_policy" {
  name = "emr-studio-service-role-permissions"
  policy = templatefile("${path.root}/policies/service_role_permissions.json", {
    bucket-name = var.emr_studio_bucket
  })

  tags = {
    Name    = "emr-studio-service-role-permissions"
    Project = "aws-and-chill"
  }
}

resource "aws_iam_role_policy_attachment" "emr_studio_service_role_attach_policy" {
  role       = aws_iam_role.emr_studio_service_role.name
  policy_arn = aws_iam_policy.emr_studio_service_role_policy.arn
}