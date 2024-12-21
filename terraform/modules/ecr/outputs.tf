output "ecr_nginx_repository_name" {
  value = aws_ecr_repository.shomotsu_ecr["nginx"].name
}

output "ecr_nginx_repository_url" {
  value = aws_ecr_repository.shomotsu_ecr["nginx"].repository_url
}

output "ecr_laravel_repository_name" {
  value = aws_ecr_repository.shomotsu_ecr["laravel"].name
}

output "ecr_laravel_repository_url" {
  value = aws_ecr_repository.shomotsu_ecr["laravel"].repository_url
}

