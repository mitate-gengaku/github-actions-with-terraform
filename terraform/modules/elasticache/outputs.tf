output "elasticache_endpoint" {
  value = aws_ssm_parameter.elasticache_host.value
}