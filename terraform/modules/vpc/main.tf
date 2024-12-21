resource "aws_vpc" "shomotsu_vpc" {
  cidr_block = var.cidr_block

  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = var.vpc_name
    Environment = var.env
  }
}