variable "application_prefix" {
  type = string
  default = "shomotsu"
}

variable "env" {
  type = string
  default = "dev"
}

variable "s3_bucket_name" {
  type = string
}

variable "cloudfront_arn" {
  type = string
}