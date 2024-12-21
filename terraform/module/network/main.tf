resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = join("-", [var.application_prefix, var.env, "vpc"])
    env = var.env
    resource = "subnet"
  }
}

resource "aws_subnet" "public_subnets" {
  for_each = var.public_subnets
  cidr_block        = each.value.cidr_block
  vpc_id            = aws_vpc.vpc.id
  availability_zone = each.value.availability_zone

  tags = {
    Name = join("-", [var.application_prefix, var.env, each.value.tag_name])
    env = var.env
    resource = "subnet"
  }
}

resource "aws_subnet" "private_subnets" {
  for_each = var.private_subnets
  cidr_block        = each.value.cidr_block
  vpc_id            = aws_vpc.vpc.id
  availability_zone = each.value.availability_zone

  tags = {
    Name = join("-", [var.application_prefix, var.env, each.value.tag_name])
    env = var.env
    resource = "subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  
  tags = {
    Name = join("-", [var.application_prefix, var.env, "igw"])
    env = var.env
    resource = "igw"
  }
}

resource "aws_route" "route" {
  destination_cidr_block  = "0.0.0.0/0"

  route_table_id = aws_route_table.public_route_table.id
  gateway_id     = aws_internet_gateway.igw.id
}

locals {
  private_route_tables = {
    production_private-1a = {
      Name = "production_rtb_private1_ap_northeast_1a"
    },
    production_private-1c = {
      Name = "production_rtb_private2_ap_northeast_1c"
    },
    production_private-1d = {
      Name = "production_rtb_private3_ap_northeast_1d"
    },
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  for_each = local.private_route_tables
  
  tags = {
    Name = join("-", [var.application_prefix, var.env, each.key])
    env = var.env
    resource = "route_table"
  }
}

resource "aws_route_table_association" "public_table_association" {
  for_each = aws_subnet.public_subnets

  subnet_id = each.value.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_table_association" {
  for_each = aws_subnet.private_subnets

  subnet_id = each.value.id
  route_table_id = aws_route_table.private_route_table[each.key].id
}