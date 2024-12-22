variable "application_prefix" {
  type = string
  default = "shomotsu"
}

variable "env" {
  type = string
  default = "dev"
}

variable "security_groups" {
  
}

variable "subnets" {
  
}

variable "certificate_arn" {
  type = string
}

variable "vpc_id" {
  type = string
}