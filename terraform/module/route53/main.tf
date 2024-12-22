resource "aws_route53_record" "shomotsu_alb_record" {
  zone_id = data.aws_route53_zone.name.zone_id
  name    = var.dev_domain_name
  type    = "A"

  allow_overwrite = true

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}


resource "aws_route53_record" "shomotsu_cloudfront_record" {
  zone_id = data.aws_route53_zone.name.zone_id
  name    = var.cloudfront_name
  type    = "A"

  allow_overwrite = true

  alias {
    name                   = var.cloudfront_cdn_domain_name
    zone_id                = var.cloudfront_cdn_domain_hosted_zone_id
    evaluate_target_health = true
  }
}