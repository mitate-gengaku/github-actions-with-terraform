output "rds_host_ssm" {
  value = var.rds_endpoint_name
}

output "rds_dbname_ssm" {
  value = data.aws_ssm_parameter.rds_dbname.value
}

output "rds_username_ssm" {
  value = data.aws_ssm_parameter.rds_username.value
}

output "rds_password_ssm" {
  value = data.aws_ssm_parameter.rds_password.value
}