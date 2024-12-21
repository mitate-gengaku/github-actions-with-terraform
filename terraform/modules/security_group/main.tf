resource "aws_security_group" "shomotsu_security_groups" {
  for_each = var.security_groups

  description = each.value.description
  name        = each.value.name
  name_prefix = each.value.name_prefix
  tags        = var.tags
  vpc_id      = var.vpc_id
}