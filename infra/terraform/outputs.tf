# VPC & Subnet
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_id" {
  value = module.vpc.subnet_id
}

# Security Groups
output "ec2_security_group_id" {
  value = module.security_group.ec2_sg_id
}

output "alb_security_group_id" {
  value = module.security_group.alb_sg_id
}

# Auto Scaling Group
output "asg_name" {
  value = module.ec2.asg_name
}

output "instance_ids" {
  value = module.ec2.instance_ids
}

output "instance_public_ips" {
  value = module.ec2.instance_public_ips
}

# ALB
output "alb_dns_name" {
  value = module.alb.alb_dns_name
}