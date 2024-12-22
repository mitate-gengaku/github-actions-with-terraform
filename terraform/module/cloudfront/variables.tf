variable "application_prefix" {
  type = string
  default = "shomotsu"
}

variable "env" {
  type = string
  default = "dev"
}

variable "oac_name" {
  type = string
}

variable "image_acm_domain" {
  type = string
}

variable "s3_origin_id" {
  type = string
}

variable "s3_origin_name" {
  type = string
}

variable "web_acl_id" {
  type = string
}

variable "us1_acm_arn" {
  type = string
}

variable "alb_dns_name" {
  type = string
}

variable "applicaiton_waf_id" {
  type = string
}

variable "aliases" {
  type = list(string)
}