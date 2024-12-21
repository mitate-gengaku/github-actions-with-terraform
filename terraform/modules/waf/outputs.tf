output "shomotsu_waf_arn" {
  value = aws_wafv2_web_acl.shomotsu_waf.arn
}

output "cloudfront_waf_arn" {
  value = aws_wafv2_web_acl.cloudfront_image_waf.arn
}