resource "aws_s3_bucket" "s3_bucket" {
  bucket = join("-", [var.application_prefix, var.env, var.s3_bucket_name])

  tags = {
    Name = var.s3_bucket_name
    env = var.env
    resource = "s3"
  }
}

resource "aws_s3_bucket_ownership_controls" "s3_ownership_controls" {
  bucket = aws_s3_bucket.s3_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_policy" "allow_cloudfront_access" {
  bucket = aws_s3_bucket.s3_bucket.id
  policy = data.aws_iam_policy_document.allow_cloudfront_access.json
}