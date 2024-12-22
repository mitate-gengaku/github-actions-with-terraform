variable "application_prefix" {
  type = string
  default = "shomotsu"
}

variable "env" {
  type = string
  default = "dev"
}

variable "dev_domain_name" {
  type = string
}

variable "alb_cloudfront_dns_name" {
  type = string
}

variable "alb_cloudfront_zone_id" {
  type = string
}

variable "cloudfront_name" {
  type = string
}

variable "cloudfront_cdn_domain_name" {
  type = string
}

variable "cloudfront_cdn_domain_hosted_zone_id" {
  type = string
}

variable "route53_domain_name" {
  type = string
}