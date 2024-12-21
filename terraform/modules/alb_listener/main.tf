resource "aws_alb_listener" "http" {
  load_balancer_arn = var.load_balancer_arn

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
}

resource "aws_alb_listener" "https" {
  load_balancer_arn = var.load_balancer_arn

  certificate_arn = var.certificate_arn

  port = "443"
  protocol = "HTTPS"

  default_action {
    type = "forward"
    target_group_arn = var.target_group_arn
  }
}