variable "application_prefix" {
  type = string
  default = "shomotsu"
}

variable "env" {
  type = string
  default = "dev"
}

variable "name" {
  type = string
}

variable "subnet_ids" {
  
}

variable "security_group_ids" {
  type = set(string)
}

variable "elasticache_name" {
  
}