variable "application_prefix" {
  type = string
  default = "shomotsu"
}

variable "env" {
  type = string
  default = "dev"
}

variable "env_s3_bucket_arn" {
  type = string
}

variable "secrets" {
  
}

variable "php_container_image" {
  type = string
}

variable "php_container_name" {
  type = string
}

variable "nginx_container_image" {
  type = string
}

variable "nginx_container_name" {
  type = string
}

variable "execution_role_arn" {
  type = string
}

variable "task_role_arn" {
  type = string
}

variable "app_key" {
  type = string
}

variable "public_subnets" {
  
}

variable "security_groups" {
  
}

variable target_group_arn {
  type = string
}