# Amazon EMR Studio IAM Configuration

This Terraform module sets up the necessary resources for Amazon EMR Studio, creating different user access levels and a service role for EMR Studio operations.

## Overview

### What is Amazon EMR Studio?

Amazon EMR Studio is a web-based integrated development environment (IDE) for fully managed Jupyter notebooks that run on Amazon EMR clusters.

- **Cost**: EMR Studio creation is free. You only pay for Amazon S3 storage and EMR clusters when using the studio
- **Team Resource**: Designed to be shared among team members with different access levels
- **Managed Service**: Fully managed Jupyter notebook environment

### Key Features

- **On-demand Cluster Access**: Launch and access EMR clusters to run Jupyter notebook jobs
- **Notebook Management**: Explore, create, and save notebooks with version control
- **Real-time Collaboration**: Work collaboratively with other users in the same workspace
- **Workflow Integration**: Run parameterized notebooks with orchestration tools like Apache Airflow or AWS MWAA
- **Git Integration**: Link code repositories such as GitHub for version control

### AWS Services Integration

- **Amazon EMR**: Connects to clusters in specified subnets
- **Amazon S3**: Stores notebook files and outputs
- **AWS IAM**: Manages user access and service permissions
- **AWS Secrets Manager**: Secures Git repository credentials
- **VPC Security Groups**: Establishes secure network channels between Studio and clusters

## Terraform Module Structure

This module creates:

1. **EMR Studio Service Role**: Allows EMR Studio to interact with AWS services
2. **IAM Users with Different Access Levels**:
   - **Admin**: Full EMR Studio administration permissions
   - **Basic**: Read-only and basic notebook operations
   - **Intermediate**: Cluster creation using templates
   - **Advanced**: Full cluster creation and configuration permissions
3.

## Prerequisites

- AWS CLI configured with appropriate permissions
- Terraform >= 0.12
- An existing S3 bucket for EMR Studio notebooks
- VPC and subnets where EMR clusters will be deployed

## Usage

### 1. Configure Variables

Create a `terraform.tfvars` file with your specific values:

```hcl
aws_region                 = "us-west-2"
emr_studio_service_role   = "EMRStudio-Service-Role"
emr_studio_bucket         = "your-emr-studio-bucket-name"
virtual_cluster_id        = "*"  # or specific cluster ID
emr_on_eks_execution_role = "*"  # or specific role name
```

### 2. Deploy Infrastructure

```bash
terraform init
terraform plan
terraform apply
```

### 3. Verify Deployment

```bash
terraform output
```

## IAM Policies and Permissions

### EMR Studio Service Role

**Purpose**: Enables EMR Studio to interact with other AWS services securely.

**Key Permissions**:
- Establish secure network channels between workspaces and clusters
- Store notebook files in Amazon S3
- Access AWS Secrets Manager for Git repository integration
- Manage EMR cluster lifecycle operations

**Files**:
- `policies/service_role_trust_policy.json`: Trust relationship with security conditions
- `policies/service_role_permissions.json`: Service-specific permissions

### User Access Levels

#### Basic User
- **Use Case**: Data analysts who need to run existing notebooks
- **Permissions**: View and execute notebooks, connect to existing clusters
- **Restrictions**: Cannot create new EMR clusters
- **Policy File**: `policies/basic_level_user_permissions.json`

#### Intermediate User
- **Use Case**: Data scientists who need to create clusters from templates
- **Permissions**: All basic permissions plus cluster creation using predefined templates
- **Restrictions**: Limited to cluster templates only
- **Policy File**: `policies/intermediate_level_user_permissions.json`

#### Advanced User
- **Use Case**: Data engineers and ML engineers who need full cluster control
- **Permissions**: All intermediate permissions plus custom cluster configuration
- **Additional Access**: Full EMR cluster management and custom configurations
- **Policy File**: `policies/advanced_level_user_permissions.json`
- **Note**: Optimized to stay within AWS IAM policy size limits (6,144 characters) by removing duplications and combining similar statements

#### Admin User
- **Use Case**: EMR Studio administrators
- **Permissions**: Full EMR Studio management including user management and studio configuration
- **Policy File**: `policies/admin_user_permissions.json`

## Security Best Practices

1. **Principle of Least Privilege**: Each user type has only the minimum permissions required
2. **Confused Deputy Protection**: Service role includes `aws:SourceArn` and `aws:SourceAccount` conditions
3. **Resource-Based Access**: Policies are scoped to specific resources and accounts
4. **Regular Review**: Periodically review and update permissions as requirements change

## Outputs

The module provides the following outputs:

- **EMR Studio Service Role**: Name, ARN, and policy ARN
- **IAM Users**: Details for all created users (admin, basic, intermediate, advanced)
- ...

## References

- [Amazon EMR Studio Management Guide](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-studio-configure.html)
- [EMR Studio Admin Permissions](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-studio-admin-permissions.html#emr-studio-admin-permissions-table)
- [EMR Studio User Permissions](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-studio-user-permissions.html)

## Troubleshooting

### Common Issues
1. **Missing S3 Bucket**: Ensure the specified S3 bucket exists before deployment
3. **VPC Configuration**: Verify that subnets and security groups are properly configured for EMR clusters