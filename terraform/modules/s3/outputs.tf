output "bucket_id" {
  value = aws_s3_bucket.shomotsu_bucket.id
}

output "bucket_arn" {
  value = aws_s3_bucket.shomotsu_bucket.arn
}

output "bucket_regional_domain_name" {
  value = aws_s3_bucket.shomotsu_bucket.bucket_regional_domain_name
}