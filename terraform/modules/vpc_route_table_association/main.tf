resource "aws_route_table_association" "shomotsu_public_table_association" {
  for_each = var.public_subnets

  subnet_id = each.value.id
  route_table_id = var.public_route_tables.id
}

resource "aws_route_table_association" "shomotsu_private_table_association" {
  for_each = var.private_subnets

  subnet_id = each.value.id
  route_table_id = var.private_route_tables[each.key].id
}