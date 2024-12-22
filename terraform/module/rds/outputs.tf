output "rds_host_ssm" {
  value = var.rds_endpoint_name
}

output "rds_dbname_ssm" {
  value = var.rds_dbname
}

output "rds_username_ssm" {
  value = var.rds_username
}

output "rds_password_ssm" {
  value = var.rds_password
}