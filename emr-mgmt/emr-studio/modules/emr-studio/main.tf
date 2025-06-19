
# EMR Studio
resource "aws_emr_studio" "main" {
  name                        = var.emr_studio_name
  auth_mode                   = var.auth_mode
  vpc_id                      = var.vpc_id
  subnet_ids                  = var.subnet_ids
  service_role                = var.service_role_arn
  workspace_security_group_id = var.workspace_security_group_id
  engine_security_group_id    = var.engine_security_group_id
  default_s3_location         = var.s3_location_emr_studio_notebooks


  tags = merge(
    var.tags,
    {
      Name    = var.emr_studio_name
      Project = "aws-and-chill"
      Team    = "Data Analytics"
    }
  )
}