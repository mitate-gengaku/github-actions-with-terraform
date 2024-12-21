variable "name" {
  type = string
}
variable "port" {
  type = number
}
variable "protocol" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "target_type" {
  type = string
}

variable "health_check_enabled" {
  type = bool
}

variable "health_check_path" {
  type = string
}

variable "health_check_interval" {
  type = number
}