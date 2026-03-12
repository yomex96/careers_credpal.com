variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "us-east-2"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  default     = "10.0.1.0/24"
}

variable "ec2_instance_type" {
  description = "EC2 instance type for the app"
  default     = "t2.micro"
}

variable "app_name" {
  description = "Name of the application"
  default     = "credpal-app"
}

variable "acm_certificate_arn" {
  description = "ARN of ACM SSL certificate"
  type        = string
}

variable "dockerhub_username" {
  description = "DockerHub username for pulling app image"
  type        = string
}

variable "docker_image_tag" {
  description = "Docker image tag to deploy"
  type        = string
  default     = "latest"
}
