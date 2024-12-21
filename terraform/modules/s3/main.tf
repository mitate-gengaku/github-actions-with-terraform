## バケットの作成
resource "aws_s3_bucket" "shomotsu_bucket" {
  bucket = var.bucket_name

  tags = var.tags
}