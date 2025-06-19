
# Data sources for existing VPC and subnets
data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  
  filter {
    name   = "subnet-id"
    values = var.subnet_ids
  }
}

# Security Group for EMR Studio Workspace
resource "aws_security_group" "emr_studio_workspace" {
  name_prefix = "${var.emr_studio_name}-workspace-"
  description = "Security group for EMR Studio workspace"
  vpc_id      = var.vpc_id

  # Allow HTTPS traffic for Studio UI
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS access for EMR Studio UI"
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All outbound traffic"
  }

  tags = {
    Name    = "${var.emr_studio_name}-workspace-sg"
    Project = "aws-and-chill"
  }
}

# Security Group for EMR Studio Engine
resource "aws_security_group" "emr_studio_engine" {
  name_prefix = "${var.emr_studio_name}-engine-"
  description = "Security group for EMR Studio engine"
  vpc_id      = var.vpc_id

  # Allow Jupyter/Zeppelin notebook communication
  ingress {
    from_port       = 18888
    to_port         = 18888
    protocol        = "tcp"
    security_groups = [aws_security_group.emr_studio_workspace.id]
    description     = "Jupyter notebook communication"
  }

  # Allow Livy server communication
  ingress {
    from_port       = 8998
    to_port         = 8998
    protocol        = "tcp"
    security_groups = [aws_security_group.emr_studio_workspace.id]
    description     = "Livy server communication"
  }

  # Allow Spark History Server
  ingress {
    from_port       = 18080
    to_port         = 18080
    protocol        = "tcp"
    security_groups = [aws_security_group.emr_studio_workspace.id]
    description     = "Spark History Server"
  }

  # Allow communication within the same security group
  ingress {
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"
    self      = true
    description = "Allow communication within security group"
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All outbound traffic"
  }

  tags = {
    Name    = "${var.emr_studio_name}-engine-sg"
    Project = "aws-and-chill"
  }
}