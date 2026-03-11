# Auto Scaling Group name
output "asg_name" {
  value = aws_autoscaling_group.app_asg.name
}

# Fetch instances launched by the ASG
data "aws_instances" "asg_instances" {
  filter {
    name   = "tag:Name"
    values = ["${var.app_name}-asg"]
  }
}

# List of instance IDs
output "instance_ids" {
  value = data.aws_instances.asg_instances.ids
}

# List of public IPs
data "aws_instances" "asg_public_ips" {
  filter {
    name   = "tag:Name"
    values = ["${var.app_name}-asg"]
  }
}

output "instance_public_ips" {
  value = [for id in data.aws_instances.asg_public_ips.ids : id]
}