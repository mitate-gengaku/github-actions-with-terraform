output "application_cloudfront_dns_name" {
  value = aws_cloudfront_distribution.applicaiton_cloudfront.domain_name
}

output "application_cloudfront_zone_id" {
  value = aws_cloudfront_distribution.applicaiton_cloudfront.hosted_zone_id
}

output "s3_cloudfront_dns_name" {
  value = aws_cloudfront_distribution.s3_cloudfront.domain_name
}

output "s3_cloudfront_zone_id" {
  value = aws_cloudfront_distribution.s3_cloudfront.hosted_zone_id
}