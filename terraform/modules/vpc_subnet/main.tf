resource "aws_subnet" "shomotsu_public_subnets" {
  for_each = var.public_subnets
  cidr_block        = each.value.cidr_block
  vpc_id            = var.vpc_id
  availability_zone = each.value.availability_zone

  tags = {
    Name = each.value.tag_name
    Environment = var.env
  }
}

resource "aws_subnet" "shomotsu_private_subnets" {
  for_each = var.private_subnets
  cidr_block        = each.value.cidr_block
  vpc_id            = var.vpc_id
  availability_zone = each.value.availability_zone

  tags = {
    Name = each.value.tag_name
    Environment = var.env
  }
}