resource "aws_ecs_cluster" "shomotsu_ecs_cluster" {
  name = var.name

  tags = var.tags
}