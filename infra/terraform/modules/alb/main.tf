resource "aws_lb" "app_lb" {
  name               = "${var.app_name}-lb"
  load_balancer_type = "application"
  security_groups    = [var.alb_sg]
  subnets            = [var.subnet_id]
}

resource "aws_lb_target_group" "app_tg" {
  name        = "${var.app_name}-tg"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}