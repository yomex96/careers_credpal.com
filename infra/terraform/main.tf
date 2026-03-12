# VPC Module
module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  app_name           = var.app_name
}

# Security Group Module
module "security_group" {
  source   = "./modules/security_group"
  vpc_id   = module.vpc.vpc_id
  app_name = var.app_name
}



# ALB Module
module "alb" {
  source              = "./modules/alb"
  vpc_id              = module.vpc.vpc_id
  subnet_id           = module.vpc.subnet_id
  alb_sg              = module.security_group.alb_sg_id
  app_name            = var.app_name
  acm_certificate_arn = var.acm_certificate_arn
}

# EC2 / Auto Scaling Group Module
module "ec2" {
  source           = "./modules/ec2"
  app_name         = var.app_name
  instance_type    = var.ec2_instance_type
  subnet_id        = module.vpc.subnet_id
  ec2_sg           = module.security_group.ec2_sg_id
  

  user_data        = <<-EOF
                      #!/bin/bash
                      sudo apt update
                      sudo apt install -y docker.io
                      sudo systemctl enable docker
                      sudo systemctl start docker
                      sudo usermod -aG docker ubuntu
                      sudo docker pull ${var.dockerhub_username}/credpal-app:${var.docker_image_tag}
                      sudo docker stop credpal-app || true
                      sudo docker rm credpal-app || true
                      sudo docker run -d -p 3000:3000 --name credpal-app ${var.dockerhub_username}/credpal-app:${var.docker_image_tag}
                      EOF
  target_group_arn = module.alb.app_tg_arn
}
