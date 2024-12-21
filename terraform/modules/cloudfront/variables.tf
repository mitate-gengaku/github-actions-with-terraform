variable "image_acm_domain" {
  type = string 
}

variable "enabled" {
  default = true
}
variable "origin_id" {}
variable "domain_name" {}
variable "origin_access_control_id" {}
variable "allowed_methods" {
  description = "Allowed HTTP methods"
  type        = list(string)
  default     = ["GET", "HEAD"]
}

variable "cached_methods" {
  description = "HTTP methods to cache"
  type        = list(string)
  default     = ["GET", "HEAD"]
}
variable "target_origin_id" {
  
}
variable "forwarded_values_query_string" {
  default = false
}
variable "forwarded_values_cookies_forward" {
  default = "none"
}
variable "viewer_protocol_policy" {
  default = "redirect-to-https"
}
variable "min_ttl" {
  default = 0
}
variable "default_ttl" {
  default = 86400
}
variable "max_ttl" {
  default = 31536000
}
variable "geo_restriction_type" {}
variable "cloudfront_default_certificate" {
  default = true
}
variable "ssl_support_method" {
  default = "sni-only"
}
variable "minimum_protocol_version" {
  default = "TLSv1.2_2021"
}
variable "web_acl_id" {
  
}
variable "tags" {}

variable "shomotsu_alb" {}

variable "us1_acm" {}
variable "app_acl_id" {
  
}