output "alb_dns_name" {
  value = aws_alb.alb.dns_name
}

output "target_group_arn" {
  value = aws_alb_target_group.alb_target_group.arn
}