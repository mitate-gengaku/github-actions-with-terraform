module "network" {
  source = "../module/network"

  public_subnets = {
    "subnet-1" = {
      availability_zone = "ap-northeast-1a",
      cidr_block        = "10.0.0.0/20",
      tag_name          = "production_public-1a"
    },
    "subnet-2" = {
      availability_zone = "ap-northeast-1c"
      cidr_block        = "10.0.16.0/20",
      tag_name          = "production_public-1c"
    },
    "subnet-3" = {
      availability_zone = "ap-northeast-1d"
      cidr_block        = "10.0.32.0/20",
      tag_name          = "production_public-1d"
    }
  }  

  private_subnets = {
    "production_private-1a" = {
      availability_zone = "ap-northeast-1a",
      cidr_block        = "10.0.128.0/20",
      tag_name          = "production_private-1a"
    },
    "production_private-1c" = {
      availability_zone = "ap-northeast-1c"
      cidr_block        = "10.0.144.0/20",
      tag_name          = "production_private-1c"
    },
    "production_private-1d" = {
      availability_zone = "ap-northeast-1d"
      cidr_block        = "10.0.160.0/20",
      tag_name          = "production_private-1d"
    }
  }
}

module "security_group" {
  source = "../module/security-groups"

  vpc_id = module.network.vpc_id
  security_groups = {
    "ecs" = {
      description = "Security group for ECS"
      name        = "security-group-ecs"
      name_prefix = null
    },
    "alb" = {
      description = "Security group for ALB"
      name        = "security-group-alb"
      name_prefix = null
    },
    "rds" = {
      description = "Security group for RDS"
      name        = "security-group-rds"
      name_prefix = null
    },
    "elasticache" = {
      description = "Security group for ElastiCache"
      name        = "security-group-elasticache"
      name_prefix = null
    }
  }
}

module "s3" {
  source = "../module/s3"
  s3_bucket_name = "bucket"
  cloudfront_arn = ""
}

module "rds" {
  source = "../module/rds"

  identifier = "rds-mysql"
  rds_sg_id = module.security_group.rds_sg_id
  subnet_ids  = [for subnet in module.network.private_subnets : subnet.id]

  rds_username = var.rds_username
  rds_password = var.rds_password
  rds_dbname = var.rds_dbname
  rds_endpoint_name = var.rds_endpoint_name
}

module "elasticache" {
  source = "../module/elasticache"

  name = var.redis_name
  subnet_ids  = [for subnet in module.network.private_subnets : subnet.id]
  elasticache_name = var.elasticache_name

  security_group_ids = [
    module.security_group.elasticache_sg_id
  ]
}

module "route53" {
  source = "../module/route53"

  route53_domain_name = "shomotsu.net."
  dev_domain_name = "dev.shomotsu.net"
  alb_cloudfront_zone_id = module.cloudfront.application_cloudfront_zone_id
  alb_cloudfront_dns_name = module.cloudfront.application_cloudfront_dns_name
  cloudfront_name = "dev-images.shomotsu.net"
  cloudfront_cdn_domain_hosted_zone_id = module.cloudfront.s3_cloudfront_zone_id
  cloudfront_cdn_domain_name = module.cloudfront.s3_cloudfront_dns_name
}

module "waf" {
  source = "../module/waf"
}

module "cloudfront" {
  source = "../module/cloudfront"

  oac_name = "shomotsu-s3-oac"
  image_acm_domain = "dev-images.shomotsu.net"
  s3_origin_id = module.s3.s3_bucket_id
  s3_origin_name = module.s3.s3_bucket_regional_domain_name
  web_acl_id = module.waf.cloudfront_image_waf_arn
  ### 
  alb_dns_name = aws_alb.alb.dns_name
  ### 
  us1_acm_arn = var.us1_acm_arn
  applicaiton_waf_id = module.waf.application_waf_arn

  aliases = [
    "dev.shomotsu.net",
  ]
}

resource "aws_alb" "alb" {
  name     = "shomotsu-development-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [
    module.security_group.alb_sg_id
  ]
  subnets = [for subnet in module.network.public_subnets : subnet.id]
}
