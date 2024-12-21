resource "aws_alb_target_group" "alb_target_group" {
  name = var.name
  port = var.port
  protocol = var.protocol
  vpc_id = var.vpc_id
  target_type = var.target_type

  health_check {
    enabled = var.health_check_enabled
    path = var.health_check_path
    interval = var.health_check_interval
  }
}