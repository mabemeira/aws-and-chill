# 🛠️ AWS and Chill

Welcome! This repository is a hands-on journal of my journey toward mastering data engineering on AWS. Here, I document real-world scripts, architectures, and projects built with AWS services — from ingestion to transformation, orchestration, and analytics — all geared toward becoming a specialist in AWS data solutions.

## 🐳 Docker Environment Setup

This project includes a Docker environment pre-configured with Terraform and AWS CLI to ensure consistent development across different systems.

### Prerequisites
- Docker installed on your system
- Git (to clone this repository)

### Quick Start

1. **Build the Docker image**
   ```bash
   docker build -t terraform-awscli-dev:latest .
   ```

2. **Run the container with volume mounting**
   ```bash
   docker run -dit --name project-aws-and-chill -v $(pwd):/workspace terraform-awscli-dev:latest /bin/bash
   ```
   
   This command:
   - Creates a detached container named `project-aws-and-chill`
   - Mounts the entire repository directory to `/workspace` inside the container
   - Allows you to work with your local files from within the container

3. **Access the container shell**
   ```bash
   docker exec -it project-aws-and-chill bash
   ```

4. **Verify installations**
   ```bash
   terraform version
   aws --version
   ```

5. **Configure AWS credentials**
   ```bash
   aws configure
   ```
   Enter your AWS Access Key ID, Secret Access Key, region, and output format.

### Working with Terraform

Once inside the container and in your project directory:

```bash
cd /workspace/(project-folder)

# Initialize Terraform
terraform init

# Review the execution plan
terraform plan

# Apply the infrastructure changes
terraform apply
```

### Container Management

- **Stop the container**: `docker stop project-aws-and-chill`
- **Start the container**: `docker start project-aws-and-chill`
- **Remove the container**: `docker rm project-aws-and-chill`
- **Rebuild image**: `docker build -t terraform-awscli-dev:latest . --no-cache`

### What's Included

The Docker environment provides:
- **Ubuntu Latest**: Clean, lightweight base system
- **Terraform 1.6.4**: Infrastructure as Code tool
- **AWS CLI v2**: Command-line interface for AWS services
- **Essential utilities**: wget, unzip, curl, openssh-client, ping

All your repository files are available at `/workspace` inside the container, allowing seamless development and testing.


