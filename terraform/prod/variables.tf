variable "aws_account_id" {
  type = string
}

variable "shomotsu_acm_id" {
  type = string
}

variable "image_acm_domain" {
  type = string
}

variable "shomotsu_us1_acm_id" {
  type = string
}

variable "app_key" {
  type = string
}

variable "dbpassword_name" {
  type = string
}

variable "rds_username_parameter_name" {
  type = string
}

variable "rds_dbname_parameter_name" {
  type = string
}

variable "rds_parameter_name" {
  type = string
}

variable "route53_domain_name" {
  type = string
}

variable "env_s3" {
  type = string
}

variable "image_tag" {
  type = string
}

variable "execution_role_arn" {
  type = string
}

variable "task_role_arn" {
  type = string
}

variable "redis_name" {
  type = string  
}