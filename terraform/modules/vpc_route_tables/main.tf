resource "aws_route_table" "shomotsu_public_route_table" {
  vpc_id = var.vpc_id
  tags = {
    Name = var.public_route_table_name
    Environment = var.env
  }
}

resource "aws_route_table" "shomotsu_private_route_table" {
  vpc_id = var.vpc_id
  for_each = var.private_route_tables

  tags = {
    Name = each.value.Name
    Environment = var.env
  }
}