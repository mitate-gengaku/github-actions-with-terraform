resource "aws_cloudwatch_log_group" "shomotsu_log_group" {
  name = "/ecs/${var.name}"
}