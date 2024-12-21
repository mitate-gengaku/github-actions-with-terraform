variable "name" {}
variable "cluster_id" {}
variable "public_subnets" {}
variable "security_groups" {}
variable "task_definition_arn" {}
variable "tags" {}
variable "target_group_arn" {
  
}

variable "load_balancer_container_name" {
  
}

variable "app_key" {
  type = string
}