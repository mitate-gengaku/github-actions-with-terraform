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