output "alb_dns_name" {
  value = aws_lb.app_lb.dns_name
}


output "app_tg_arn" {
  value = aws_lb_target_group.app_tg.arn
}

