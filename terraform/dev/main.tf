resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  enable_dns_hostnames = true
  enable_dns_support = true

}

locals {
  public_subnets = {
    "subnet-1" = {
      availability_zone = "ap-northeast-1a",
      cidr_block        = "10.0.0.0/20",
      tag_name          = "production_public-1a"
    },
    "subnet-2" = {
      availability_zone = "ap-northeast-1c"
      cidr_block        = "10.0.16.0/20",
      tag_name          = "production_public-1c"
    },
    "subnet-3" = {
      availability_zone = "ap-northeast-1d"
      cidr_block        = "10.0.32.0/20",
      tag_name          = "production_public-1d"
    }
  }  

  private_subnets = {
    "production_private-1a" = {
      availability_zone = "ap-northeast-1a",
      cidr_block        = "10.0.128.0/20",
      tag_name          = "production_private-1a"
    },
    "production_private-1c" = {
      availability_zone = "ap-northeast-1c"
      cidr_block        = "10.0.144.0/20",
      tag_name          = "production_private-1c"
    },
    "production_private-1d" = {
      availability_zone = "ap-northeast-1d"
      cidr_block        = "10.0.160.0/20",
      tag_name          = "production_private-1d"
    }
  }
}

resource "aws_subnet" "public_subnets" {
  for_each = local.public_subnets
  cidr_block        = each.value.cidr_block
  vpc_id            = aws_vpc.vpc.id
  availability_zone = each.value.availability_zone
}

resource "aws_subnet" "private_subnets" {
  for_each = local.private_subnets
  cidr_block        = each.value.cidr_block
  vpc_id            = aws_vpc.vpc.id
  availability_zone = each.value.availability_zone
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  
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