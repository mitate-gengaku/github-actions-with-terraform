variable "rds_username" {
  type = string
}

variable "rds_dbname" {
  type = string
}

variable "rds_password" {
  type = string
}

variable "rds_endpoint_name" {
  type = string
}

variable "redis_name" {
  type = string
}

variable "elasticache_name" {
  type = string
}

variable "tokyo_acm_arn" {
  type = string
}
variable "us1_acm_arn" {
  type = string
}

variable "env_s3_bucket_arn" {
  type = string
}

variable "task_role_arn" {
  type = string
}

variable "execution_role_arn" {
  type = string
}

variable "app_key" {
  type = string
}

variable "account_id" {
  type = string
}