output "task_definition_arn" {
  value = aws_ecs_task_definition.shomotsu_task_definition.arn
}
output "nginx_container_name" {
  value = var.nginx_container_name
}