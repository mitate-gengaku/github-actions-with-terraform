resource "aws_route" "shomotsu_public_route" {
  destination_cidr_block = var.cidr_block

  route_table_id = var.route_table_id
  gateway_id = var.gateway_id
}