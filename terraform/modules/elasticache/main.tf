resource "aws_elasticache_serverless_cache" "shomotsu_elasticache_cluster" {
  count = 1
  name = var.name
  description = var.description

  engine = var.engine
  cache_usage_limits {
    data_storage {
      maximum = 10
      unit    = "GB"
    }
    ecpu_per_second {
      maximum = var.ecpu_per_second_maximum
    }
  }

  kms_key_id = var.kms_key_arn
  major_engine_version = var.major_engine_version
  security_group_ids = var.security_group_ids
  subnet_ids = [for subnet in var.subnets : subnet.id]
}

resource "aws_ssm_parameter" "elasticache_host" {
  name = "/shomotsu/elasticache/host"

  type = "String"
  value = "${aws_elasticache_serverless_cache.shomotsu_elasticache_cluster[0].endpoint[0].address}"
}