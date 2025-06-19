
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

# EMR Default Service Role (EMR_DefaultRole_V2)
resource "aws_iam_role" "emr_default_role" {
  name = "EMR_DefaultRole_V2"
  assume_role_policy = templatefile("${path.root}/policies/emr_default_role_trust_policy.json", {
    aws-account-id = var.aws_account_id
    region         = var.aws_region
  })

  tags = {
    Name    = "EMR_DefaultRole_V2"
    Project = "aws-and-chill"
  }
}

# Attach AWS managed policy to EMR default service role
resource "aws_iam_role_policy_attachment" "emr_default_role_policy" {
  role       = aws_iam_role.emr_default_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEMRServicePolicy_v2"
}

# Additional EC2 permissions for EMR service role
resource "aws_iam_policy" "emr_default_role_ec2_permissions" {
  name   = "EMRDefaultRoleEC2Permissions"
  policy = file("${path.root}/policies/emr_default_role_ec2_permissions.json")

  tags = {
    Name    = "EMRDefaultRoleEC2Permissions"
    Project = "aws-and-chill"
  }
}

resource "aws_iam_role_policy_attachment" "emr_default_role_ec2_permissions" {
  role       = aws_iam_role.emr_default_role.name
  policy_arn = aws_iam_policy.emr_default_role_ec2_permissions.arn
}

# EMR EC2 Default Role (EMR_EC2_DefaultRole)
resource "aws_iam_role" "emr_ec2_default_role" {
  name = "EMR_EC2_DefaultRole"
  assume_role_policy = templatefile("${path.root}/policies/emr_ec2_default_role_trust_policy.json", {
    aws-account-id = var.aws_account_id
  })

  tags = {
    Name    = "EMR_EC2_DefaultRole"
    Project = "aws-and-chill"
  }
}

# Attach AWS managed policy to EMR EC2 default role
resource "aws_iam_role_policy_attachment" "emr_ec2_default_role_policy" {
  role       = aws_iam_role.emr_ec2_default_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceforEC2Role"
}

# Create instance profile for EMR EC2 default role
resource "aws_iam_instance_profile" "emr_ec2_default_instance_profile" {
  name = "EMR_EC2_DefaultRole"
  role = aws_iam_role.emr_ec2_default_role.name

  tags = {
    Name    = "EMR_EC2_DefaultRole"
    Project = "aws-and-chill"
  }
}