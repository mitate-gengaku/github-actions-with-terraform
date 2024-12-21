################################################
# VPC
################################################

module "vpc" {
  source = "../modules/vpc"

  cidr_block = "10.0.0.0/16"

  vpc_name = "shomotsu_development_vpc"
  env      = "development"
}

module "subnet" {
  source = "../modules/vpc_subnet"

  vpc_id = module.vpc.vpc_id
  env    = "development"
  public_subnets = {
    "subnet-1" = {
      availability_zone = "ap-northeast-1a",
      cidr_block        = "10.0.0.0/20",
      tag_name          = "shomotsu_development_public-1a"
    },
    "subnet-2" = {
      availability_zone = "ap-northeast-1c"
      cidr_block        = "10.0.16.0/20",
      tag_name          = "shomotsu_development_public-1c"
    },
    "subnet-3" = {
      availability_zone = "ap-northeast-1d"
      cidr_block        = "10.0.32.0/20",
      tag_name          = "shomotsu_development_public-1d"
    }
  }  

  private_subnets = {
    "shomotsu_development_private-1a" = {
      availability_zone = "ap-northeast-1a",
      cidr_block        = "10.0.128.0/20",
      tag_name          = "shomotsu_development_private-1a"
    },
    "shomotsu_development_private-1c" = {
      availability_zone = "ap-northeast-1c"
      cidr_block        = "10.0.144.0/20",
      tag_name          = "shomotsu_development_private-1c"
    },
    "shomotsu_development_private-1d" = {
      availability_zone = "ap-northeast-1d"
      cidr_block        = "10.0.160.0/20",
      tag_name          = "shomotsu_development_private-1d"
    }
  }
}

module "igw" {
  source = "../modules/vpc_igw"

  vpc_id = module.vpc.vpc_id
  name   = "shomotsu_development_internet_gateway"
  env    = "development"
}

module "route" {
  source = "../modules/vpc_route"

  cidr_block     = "0.0.0.0/0"
  route_table_id = module.route_tables.route_table_id
  gateway_id     = module.igw.igw_id
}

module "route_tables" {
  source = "../modules/vpc_route_tables"

  vpc_id                  = module.vpc.vpc_id
  public_route_table_name = "shomotsu_development_rtb_public"
  env                     = "development"
  private_route_tables = {
    shomotsu_development_private-1a = {
      Name = "shomotsu_development_rtb_private1_ap_northeast_1a"
    },
    shomotsu_development_private-1c = {
      Name = "shomotsu_development_rtb_private2_ap_northeast_1c"
    },
    shomotsu_development_private-1d = {
      Name = "shomotsu_development_rtb_private3_ap_northeast_1d"
    },
  }
}

module "route_table_association" {
  source = "../modules/vpc_route_table_association"

  public_subnets       = module.subnet.public_subnets
  public_route_tables  = module.route_tables.public_route_tables
  private_subnets      = module.subnet.private_subnets
  private_route_tables = module.route_tables.private_route_tables
}

################################################
# ECR
################################################

module "ecr_repository" {
  source = "../modules/ecr"

  repositories = {
    "nginx" = {
      image_tag_mutability = "IMMUTABLE"
      name                 = "shomotsu_development_nginx_repository"
      tags                 = {
        Name = "shomotsu_development_nginx_repository"
        Environment = "development"
      }

      image_scanning_configuration = {
        scan_on_push = true
      }
    }
    "laravel" = {
      image_tag_mutability = "IMMUTABLE"
      name                 = "shomotsu_development_laravel_repository"
      tags                 = {
        Name = "shomotsu_development_laravel_repository"
        Environment = "development"
      }

      image_scanning_configuration = {
        scan_on_push = true
      }
    }
  }
}

################################################
# Security group
################################################

module "security_group" {
  source = "../modules/security_group"

  vpc_id = module.vpc.vpc_id

  security_groups = {
    "ecs" = {
      description = "Security group for ECS"
      name        = "ECS_of_Shomotsu"
      name_prefix = null
    },
    "alb" = {
      description = "Security group for ALB"
      name        = "ALB_of_Shomotsu"
      name_prefix = null
    },
    "rds" = {
      description = "Security group for RDS"
      name        = "RDS_of_Shomotsu"
      name_prefix = null
    },
    "elasticache" = {
      description = "Security group for ElastiCache"
      name        = "ElastiCache_of_Shomotsu"
      name_prefix = null
    }
  }

  tags                 = {
    Environment = "development"
  }
}

module "security_group_rule" {
  source = "../modules/security_group_rule"

  alb_sg_id         = module.security_group.alb_sg_id
  ecs_sg_id         = module.security_group.ecs_sg_id
  rds_sg_id         = module.security_group.rds_sg_id
  elasticache_sg_id = module.security_group.elasticache_sg_id
}

################################################
# Route 53
################################################

module "route53_record" {
  source = "../modules/route53_record"

  route53_domain_name = var.route53_domain_name
  domain_name = "dev.shomotsu.net"
  cloudfront_name = "images.shomotsu.net"
  alb_zone_id =  module.cloudfront.shomotsu_cloudfront_zone_id
  alb_dns_name = module.cloudfront.shomotsu_cloudfront_cdn_domain_name
  cloudfront_cdn_domain_hosted_zone_id = module.cloudfront.cloudfront_zone_id
  cloudfront_cdn_domain_name = module.cloudfront.cloudfront_cdn_domain_name
}

################################################
# RDS
################################################

module "rds_subnet" {
  source = "../modules/rds_subnet"

  name        = "shomotsu_development_rds_subnet"
  description = "shomotsu development rds subnet"
  subnet_ids  = [for subnet in module.subnet.private_subnets : subnet.id]

  tags = {
    Name        = "Shomotsu Development RDS Subnet Group"
    Environment = "development"
  }
}

module "rds" {
  source = "../modules/rds"

  allocated_storage           = 10
  storage_type                = "gp2"
  engine                      = "mysql"
  engine_version              = "8.0.35"
  identifier                  = "shomotsu-development-mysql-database"
  instance_class              = "db.t3.micro"
  manage_master_user_password = true
  skip_final_snapshot         = true
  rds_sg_id                   = module.security_group.rds_sg_id
  subnet_id                   = module.rds_subnet.rds_subnet_id

  dbpassword_name = var.dbpassword_name
  rds_username_parameter_name = var.rds_username_parameter_name
  rds_dbname_parameter_name = var.rds_dbname_parameter_name
  rds_parameter_name = var.rds_parameter_name
  
  tags = {
    Environment = "development"
  }
}

################################################
# Kms Key
################################################

module "kms" {
  source = "../modules/kms"

  description = "Key for ElastCache"
  tags = {
    Environment = "development"
  }
}

################################################
# ElastiCache
################################################

module "elasticache_subnet" {
  source = "../modules/elasticache_subnet"

  name        = "shomotsu-development-elasticache-subnet"
  description = "shomotsu development elasticache subnet"

  subnet_ids = [for subnet in module.subnet.private_subnets : subnet.id]

  tags = {
    Name        = "Shomotsu Development ElastiCache Subnet Group"
    Environment = "development"
  }
}

module "elasticache" {
  source = "../modules/elasticache"

  name        = var.redis_name
  description = "shomotsu development serverless cache"

  data_storage_maximum = 10
  data_storage_unit    = "GB"

  kms_key_arn = module.kms.cache_key_arn

  security_group_ids = [
    module.security_group.elasticache_sg_id
  ]

  subnets = module.subnet.private_subnets
}

################################################
# S3
################################################

module "s3_bucket" {
  source = "../modules/s3"

  bucket_name = "shomotsu-development-bucket"

  tags = {
    Name        = "shomotsu-development-bucket"
    Environment = "development"
  }
}

module "s3_ownership" {
  source = "../modules/s3_ownership"

  bucket_id = module.s3_bucket.bucket_id
}

module "s3_bucket_policy" {
  source = "../modules/s3_bucket_policy"

  bucket_id  = module.s3_bucket.bucket_id
  bucket_arn = module.s3_bucket.bucket_arn

  source_arn = module.cloudfront.cloudfront_arn
}

################################################
# Cloudfront
################################################

module "cloudfront" {
  source = "../modules/cloudfront"

  image_acm_domain = var.image_acm_domain

  origin_id                = module.s3_bucket.bucket_id
  domain_name              = module.s3_bucket.bucket_regional_domain_name
  origin_access_control_id = module.cloudfront_oac.cloudfront_oac_id

  target_origin_id = module.s3_bucket.bucket_id

  geo_restriction_type           = "whitelist"
  cloudfront_default_certificate = false

  web_acl_id = module.waf.cloudfront_waf_arn
  app_acl_id = module.waf.shomotsu_waf_arn

  tags = {
    Environment = "development"
  }

  shomotsu_alb = module.alb.alb_dns_name
  us1_acm = var.shomotsu_us1_acm_id
}

module "cloudfront_oac" {
  source = "../modules/cloudfront_oac"

  name                              = "shomotsu-development-bucket.s3.ap-northeast-1.amazonaws.com"
  description                       = "shomotsu development oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}


################################################
# Application Load Balancer
################################################

module "alb" {
  source = "../modules/alb"

  name     = "shomotsu-development-alb"
  internal = false
  security_groups = [
    module.security_group.alb_sg_id
  ]
  subnets = [for subnet in module.subnet.public_subnets : subnet.id]
}

module "alb_target_group" {
  source = "../modules/alb_target_group"

  name        = "shomotsu-development-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
  target_type = "ip"

  health_check_enabled  = true
  health_check_path     = "/health_check"
  health_check_interval = 300
}

module "alb_listener" {
  source = "../modules/alb_listener"

  load_balancer_arn = module.alb.alb_arn
  certificate_arn   = "arn:aws:acm:ap-northeast-1:${var.aws_account_id}:certificate/${var.shomotsu_acm_id}"
  target_group_arn  = module.alb_target_group.target_group_arn
}

################################################
# CloudWatch
################################################

module "cloudwatch_log" {
  source = "../modules/cloudwatch"

  name = "shomotsu-development-task-definition"
}

################################################
# WAF
################################################
module "waf" {
  source = "../modules/waf"
  shomotsu_tags = {
    Environment = "development"
  }
  cloudfront_tags = {
    Environment = "development"
  }

  shomotsu_bucket_name = "shomotsu-development-log-bucket"
  cloudfront_bucket_name = "shomotsu-development-cloudfront-log-bucket"
  tags = {
    Environment = "development"
  }
}

################################################
# ECS
################################################

module "ecs_cluster" {
  source = "../modules/ecs_cluster"

  name = "shomotsu-development-ecs-cluster"

  tags = {
    Environment = "development"
  }
}

module "ecs_task_definition" {
  source = "../modules/ecs-task-definition"

  family_name = "shomotsu-development-task-definition"

  secrets = [
    {
      "name" : "APP_ENV",
      "valueFrom": module.ecs.app_key_ssm
    },
    {
      "name" : "DB_HOST",
      "valueFrom" : module.rds.rds_host_ssm
    },
    {
      "name" : "DB_DATABASE",
      "valueFrom" : module.rds.rds_dbname_ssm
    },
    {
      "name" : "DB_USERNAME",
      "valueFrom" : module.rds.rds_username_ssm
    },
    {
      "name" : "DB_PASSWORD",
      "valueFrom" : module.rds.aws_rds_db_password_arn
    },
  ]

  env_s3 = var.env_s3
  nginx_container_name = "shomotsu_development_nginx_repository"
  laravel_container_name = "shomotsu_development_laravel_repository"
  nginx_container_image = "${module.ecr_repository.ecr_nginx_repository_url}:${var.image_tag}"
  laravel_container_image = "${module.ecr_repository.ecr_laravel_repository_url}:${var.image_tag}"
  task_role_arn = var.task_role_arn
  execution_role_arn = var.execution_role_arn

  tags = {
    Environment = "development"
  }
}

module "ecs" {
  source = "../modules/ecs"

  name       = "shomotsu_development_ecs_service"
  cluster_id = module.ecs_cluster.cluster_id

  public_subnets = [for subnet in module.subnet.public_subnets : subnet.id]

  security_groups = [
    module.security_group.ecs_sg_id
  ]

  task_definition_arn = module.ecs_task_definition.task_definition_arn

  target_group_arn = module.alb_target_group.target_group_arn

  load_balancer_container_name = module.ecs_task_definition.nginx_container_name

  app_key = var.app_key
  tags = {
    Environment = "development"
  }
}
