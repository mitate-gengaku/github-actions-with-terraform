data "aws_acm_certificate" "dev" {
  domain = "shomotsu.net."
}

resource "aws_alb" "alb" {
  name     = join("-", [var.application_prefix, var.env, "alb"])
  internal = false
  load_balancer_type = "application"
  security_groups = var.security_groups
  subnets = var.subnets

  tags = {
    Name = join("-", [var.application_prefix, var.env, "alb"])
    resource = "alb"
    env = var.env
  }
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.alb.arn

  port = "80"
  protocol = "HTTP"
  
  default_action {
    type = "redirect"
    
    redirect {
      port = "443"
      protocol = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  tags = {
    resource = "alb_listener"
    env = var.env
  }
}

resource "aws_alb_listener" "https" {
  load_balancer_arn = aws_alb.alb.arn

  certificate_arn = data.aws_acm_certificate.dev.arn

  port = "443"
  protocol = "HTTPS"

  default_action {
    type = "forward"
    target_group_arn = aws_alb_target_group.alb_target_group.arn
  }

  tags = {
    resource = "alb_listener"
    env = var.env
  }
}

resource "aws_alb_target_group" "alb_target_group" {
  name = join("-", [var.application_prefix, var.env, "target-group"])
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id
  target_type = "ip"

  health_check {
    enabled = true
    path =  "/health_check"
    interval = 300
  }

  tags = {
    Name = join("-", [var.application_prefix, var.env, "target-group"])
    resource = "target_group"
    env = var.env
  }
}