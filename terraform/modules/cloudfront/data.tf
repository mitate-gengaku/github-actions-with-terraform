provider "aws" {
  region = "us-east-1"
  alias  = "us-east-1"
}

data "aws_acm_certificate" "s3_acm" {
  provider = aws.us-east-1
  domain = var.image_acm_domain
}