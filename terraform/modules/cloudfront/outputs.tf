output "cloudfront_arn" {
  value = aws_cloudfront_distribution.shomotsu_distribution.arn
}

output "cloudfront_cdn_domain_name" {
  value = aws_cloudfront_distribution.shomotsu_distribution.domain_name
}

output "cloudfront_zone_id" {
  value = aws_cloudfront_distribution.shomotsu_distribution.hosted_zone_id
}

output "shomotsu_cloudfront_arn" {
  value = aws_cloudfront_distribution.shomotsu_cloudfront.arn
}

output "shomotsu_cloudfront_cdn_domain_name" {
  value = aws_cloudfront_distribution.shomotsu_cloudfront.domain_name
}

output "shomotsu_cloudfront_zone_id" {
  value = aws_cloudfront_distribution.shomotsu_cloudfront.hosted_zone_id
}