variable "app_name" {
  description = "Application name"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where EC2 instances will be launched"
  type        = string
}

variable "ec2_sg" {
  description = "Security group ID for EC2 instances"
  type        = string
}

variable "user_data" {
  description = "User data script for EC2"
  type        = string
}

# variable "key_name" {
#   description = "Key pair name for EC2"
#   type        = string
# }

variable "target_group_arn" {
  description = "ALB target group ARN for Auto Scaling Group"
  type        = string
}
