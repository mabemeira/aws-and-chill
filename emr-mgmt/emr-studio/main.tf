provider "aws" {
  region = "us-west-2"
}

resource "aws_iam_policy" "admin_policy" {
  name        = "emr-mgmt-emr-studio-admin"
  policy      = file("policies/admin_permissions.json")
}

resource "aws_iam_user" "admin_user" {
  name = "emr-mgmt-emr-studio-admin"
}

resource "aws_iam_user_policy_attachment" "emr_mgmt_emr_studio_admin_attach_policy" {
  user       = aws_iam_user.admin_user.name
  policy_arn = aws_iam_policy.admin_policy.arn
}
