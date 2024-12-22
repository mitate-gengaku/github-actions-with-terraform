output "nginx_repository_name" {
  value = aws_ecr_repository.ecr["nginx"].name
}

output "nginx_repository_url" {
  value = aws_ecr_repository.ecr["nginx"].repository_url
}

output "php_repository_name" {
  value = aws_ecr_repository.ecr["php"].name
}

output "php_repository_url" {
  value = aws_ecr_repository.ecr["php"].repository_url
}
