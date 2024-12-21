variable "name" {}
variable "description" {}
variable "engine" {
  default = "redis"
}
variable "data_storage_maximum" {}
variable "data_storage_unit" {}
variable "ecpu_per_second_maximum" {
  default = 5000
}
variable "kms_key_arn" {}
variable "major_engine_version" {
  default = "7"
}
variable "security_group_ids" {
  type = set(string)
}
variable "subnets" {}