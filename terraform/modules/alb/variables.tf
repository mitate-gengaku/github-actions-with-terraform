variable "name" {
  type = string
}

variable "enable_deletion_protection" {
  default = false
}

variable "internal" {
  type = bool
}

variable "security_groups" {
  type = set(string)
}

variable "subnets" {
  type = set(string)
}