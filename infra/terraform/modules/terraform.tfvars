# ----------------------
# Terraform Variables
# ----------------------

# Your AWS region (optional, default is us-east-1)
aws_region = "us-east-2"

# CIDR blocks (optional, defaults already in variables.tf)
vpc_cidr           = "10.0.0.0/16"
public_subnet_cidr = "10.0.1.0/24"

# EC2 instance type (optional, default t2.micro)
ec2_instance_type = "t2.micro"

# Name of your application
app_name = "credpal-app"

# DockerHub username (required to pull the app image)
dockerhub_username = "yomex96"

# ACM Certificate ARN for HTTPS
acm_certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/abcd1234-efgh-5678-ijkl-9012mnopqrst"
