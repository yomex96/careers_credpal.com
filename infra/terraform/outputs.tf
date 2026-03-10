# VPC ID
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.credpal_vpc.id
}

# Subnet ID
output "subnet_id" {
  description = "The ID of the subnet"
  value       = aws_subnet.credpal_subnet.id
}

# Security Group ID
output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.credpal_sg.id
}

# EC2 Instance ID
output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.credpal_server.id
}

# Public IP of EC2 instance
output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.credpal_server.public_ip
}

# AWS Region
output "region" {
  description = "AWS region used for deployment"
  value       = var.region
}

# Node.js App Port
output "app_port" {
  description = "Port on which the Node.js app will run"
  value       = var.app_port
}

# SSH Port
output "ssh_port" {
  description = "Port for SSH access to EC2"
  value       = var.ssh_port
}