# Admin User
resource "aws_iam_policy" "admin_user_policy" {
  name = "emr-mgmt-emr-studio-admin-user-policy"
  policy = templatefile("policies/admin_user_permissions.json", {
    region                  = var.aws_region
    aws-account-id          = data.aws_caller_identity.current.account_id
    emr-studio-service-role = var.emr_studio_service_role
  })
}

resource "aws_iam_user" "admin_user" {
  name = "emr-mgmt-emr-studio-admin-user"
}

resource "aws_iam_user_policy_attachment" "admin_user_attach_policy" {
  user       = aws_iam_user.admin_user.name
  policy_arn = aws_iam_policy.admin_user_policy.arn
}

# EMR Studio Service Role
resource "aws_iam_role" "emr_studio_service_role" {
  name = var.emr_studio_service_role
  assume_role_policy = templatefile("policies/service_role_trust_policy.json", {
    region         = var.aws_region
    aws-account-id = data.aws_caller_identity.current.account_id
  })
}

resource "aws_iam_policy" "emr_studio_service_role_policy" {
  name = "emr-studio-service-role-permissions"
  policy = templatefile("policies/service_role_permissions.json", {
    bucket-name = var.emr_studio_bucket
  })
}

resource "aws_iam_role_policy_attachment" "emr_studio_service_role_attach_policy" {
  role       = aws_iam_role.emr_studio_service_role.name
  policy_arn = aws_iam_policy.emr_studio_service_role_policy.arn
}

# Basic User
resource "aws_iam_policy" "basic_user_policy" {
  name = "emr-mgmt-emr-studio-basic-user-policy"
  policy = templatefile("policies/basic_level_user_permission.json", {
    aws-account-id          = data.aws_caller_identity.current.account_id
    region                  = var.aws_region
    emr-studio-service-role = var.emr_studio_service_role
  })
}

resource "aws_iam_user" "basic_user" {
  name = "emr-mgmt-emr-studio-basic-user"
}

resource "aws_iam_user_policy_attachment" "basic_user_attach_policy" {
  user       = aws_iam_user.basic_user.name
  policy_arn = aws_iam_policy.basic_user_policy.arn
}

# Intermediate User
resource "aws_iam_policy" "intermediate_user_policy" {
  name = "emr-mgmt-emr-studio-intermediate-user-policy"
  policy = templatefile("policies/intermediate_level_user_permissions.json", {
    region                  = var.aws_region
    aws-account-id          = data.aws_caller_identity.current.account_id
    emr-studio-service-role = var.emr_studio_service_role
  })
}

resource "aws_iam_user" "intermediate_user" {
  name = "emr-mgmt-emr-studio-intermediate-user"
}

resource "aws_iam_user_policy_attachment" "intermediate_user_attach_policy" {
  user       = aws_iam_user.intermediate_user.name
  policy_arn = aws_iam_policy.intermediate_user_policy.arn
}

# Advanced User
resource "aws_iam_policy" "advanced_user_policy" {
  name = "emr-mgmt-emr-studio-advanced-user-policy"
  policy = templatefile("policies/advanced_level_user_permission.json", {
    region                  = var.aws_region
    aws-account-id          = data.aws_caller_identity.current.account_id
    emr-studio-service-role = var.emr_studio_service_role
  })
}

resource "aws_iam_user" "advanced_user" {
  name = "emr-mgmt-emr-studio-advanced-user"
}

resource "aws_iam_user_policy_attachment" "advanced_user_attach_policy" {
  user       = aws_iam_user.advanced_user.name
  policy_arn = aws_iam_policy.advanced_user_policy.arn
}