output "alb_sg_id" {
  value = aws_security_group.security_group["alb"].id
}
output "ecs_sg_id" {
  value = aws_security_group.security_group["ecs"].id
}
output "rds_sg_id" {
  value = aws_security_group.security_group["rds"].id
}
output "elasticache_sg_id" {
  value = aws_security_group.security_group["elasticache"].id
}