variable "env_s3" {
  type = string
}

variable "laravel_container_image" {
}

variable "laravel_container_name" {}

variable "nginx_container_image" {
}

variable "nginx_container_name" {}

variable execution_role_arn {
  type = string
}

variable "task_role_arn" {
  type = string
}

variable "family_name" {
  
}

variable "secrets" {
  
}

variable "tags" {
  
}