resource "aws_s3_bucket_ownership_controls" "shomotsu_ownership_controls" {
  bucket = var.bucket_id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}