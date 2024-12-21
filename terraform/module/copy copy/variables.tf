variable "application_prefix" {
  type = string
  default = "shomotsu"
}

variable "env" {
  type = string
  default = "dev"
}

variable "rds_sg_id" {
  type = string
}

variable "identifier" {
  type = string
}

variable "subnet_ids" {
  
}

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