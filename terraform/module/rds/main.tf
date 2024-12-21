resource "aws_db_subnet_group" "rds_subnet" {
  name = join("-", [var.application_prefix, var.env, "rds-subnet"])
  subnet_ids = var.subnet_ids

  tags = {
    Name = join("-", [var.application_prefix, var.env, "rds-subnet"])
    resource = "subnet"
    env = var.env
  }
}

resource "aws_db_instance" "mysql_db" {
  apply_immediately = true
  allocated_storage           = 10
  backup_retention_period = 0
  monitoring_interval = 0

  performance_insights_retention_period = 0
  storage_type                = "gp2"
  engine                      = "mysql"
  engine_version              = "8.0.35"
  identifier = join("-", [var.application_prefix, var.env, var.identifier])
  instance_class              = "db.t3.micro"
  username       = data.aws_ssm_parameter.rds_username.value
  password = data.aws_ssm_parameter.rds_password.value
  skip_final_snapshot         = true
  vpc_security_group_ids = [
    var.rds_sg_id
  ]
  db_name = data.aws_ssm_parameter.rds_dbname.value
  db_subnet_group_name = aws_db_subnet_group.rds_subnet.id
  tags = {
    Name = join("-", [var.application_prefix, var.env, var.identifier])
    env = var.env
    resource = "rds"
  }
}

data "aws_ssm_parameter" "rds_username" {
  name = var.rds_username
}

data "aws_ssm_parameter" "rds_dbname" {
  name = var.rds_dbname
}

data "aws_ssm_parameter" "rds_password" {
  name = var.rds_password
}

resource "aws_ssm_parameter" "rds_endpoint" {
  name = var.rds_endpoint_name

  type        = "SecureString"
  value = sensitive(aws_db_instance.mysql_db.endpoint)
  tags = {
    name = var.rds_endpoint_name
    resource = "ssm"
    env = var.env
  }
}