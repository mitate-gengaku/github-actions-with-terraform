output "application_waf_arn" {
  value = aws_wafv2_web_acl.application_waf.arn
}

output "cloudfront_image_waf_arn" {
  value = aws_wafv2_web_acl.cloudfront_image_waf.arn
}