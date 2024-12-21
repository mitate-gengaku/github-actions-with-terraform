resource "aws_internet_gateway" "shomotsu_internet_gateway" {
  vpc_id = var.vpc_id
  tags = {
    Name = var.name
    Environment = var.env
  }
}