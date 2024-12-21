output "alb_sg_id" {
  value = aws_security_group.shomotsu_security_groups["alb"].id
}
output "ecs_sg_id" {
  value = aws_security_group.shomotsu_security_groups["ecs"].id
}
output "rds_sg_id" {
  value = aws_security_group.shomotsu_security_groups["rds"].id
}
output "elasticache_sg_id" {
  value = aws_security_group.shomotsu_security_groups["elasticache"].id
}