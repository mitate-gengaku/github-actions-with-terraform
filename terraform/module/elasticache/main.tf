resource "aws_elasticache_subnet_group" "elasticache_subnet_group" {
  name = join("-", [var.application_prefix, var.env, "elasticache-subnet"])
  subnet_ids = var.subnet_ids

  tags = {
    Name = join("-", [var.application_prefix, var.env, "elasticache-subnet"])
    resource = "subnet"
    env = var.env
  }
}

resource "aws_elasticache_serverless_cache" "elasticache_cluster" {
  count = 1
  name = join("-", [var.application_prefix, var.env, var.name])

  engine = "redis"

  cache_usage_limits {
    data_storage {
      maximum = 10
      unit    = "GB"
    }
    ecpu_per_second {
      maximum = 5000
    }
  }

  kms_key_id = aws_kms_key.cache_key.arn
  major_engine_version = "7"
  security_group_ids = var.security_group_ids
  subnet_ids = var.subnet_ids
}

resource "aws_ssm_parameter" "elasticache_host" {
  name = "/shomotsu/elasticache/host"

  type = "String"
  value = "${aws_elasticache_serverless_cache.elasticache_cluster[0].endpoint[0].address}"
}

resource "aws_kms_key" "cache_key" {
  description = "Key for ElastCache"
  tags = {
    resource = "kms"
    env = var.env
  }
}