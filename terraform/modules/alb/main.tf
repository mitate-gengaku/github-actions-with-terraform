resource "aws_alb" "alb" {
  name = var.name
  internal = var.internal
  load_balancer_type = "application"

  enable_deletion_protection = var.enable_deletion_protection
  security_groups = var.security_groups
  subnets = var.subnets
}