resource "aws_kms_key" "cache_key" {
  description = var.description
  tags = var.tags
}