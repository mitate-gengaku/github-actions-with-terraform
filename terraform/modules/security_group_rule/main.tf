################################################
# Security group rule of ALB (ingress)
################################################

resource "aws_security_group_rule" "ALB_of_Shomotsu_Ingress_Rule_For_Http" {
  security_group_id = var.alb_sg_id
  type = "ingress"

  cidr_blocks      = [
    "0.0.0.0/0",
  ]
  description      = null
  from_port        = 80
  ipv6_cidr_blocks = [
    "::/0",
  ]
  protocol         = "tcp"
  to_port          = 80
}

resource "aws_security_group_rule" "ALB_of_Shomotsu_Ingress_Rule_For_Https" {
  security_group_id = var.alb_sg_id
  type = "ingress"
  
  cidr_blocks      = [
    "0.0.0.0/0",
  ]
  description      = null
  from_port        = 443
  ipv6_cidr_blocks = [
    "::/0",
  ]
  protocol         = "tcp"
  to_port          = 443
}

################################################
# Security group rule of ALB (egress)
################################################

resource "aws_security_group_rule" "ALB_of_Shomotsu_Egress_Rule_For_Http" {
  security_group_id = var.alb_sg_id
  source_security_group_id = var.ecs_sg_id

  type = "egress"
  
  description      = null
  from_port        = 80
  
  protocol         = "tcp"
  to_port          = 80
}

resource "aws_security_group_rule" "ALB_of_Shomotsu_Egress_Rule_For_Https" {
  security_group_id = var.alb_sg_id
  source_security_group_id = var.ecs_sg_id

  type = "egress"
  
  description      = null
  from_port        = 443
  
  protocol         = "tcp"
  to_port          = 443
}

################################################
# Security group rule of ECS (ingress)
################################################

resource "aws_security_group_rule" "ECS_of_Shomotsu_Ingress_Rule_For_Http" {
  security_group_id = var.ecs_sg_id
  source_security_group_id = var.alb_sg_id

  type = "ingress"
  
  description      = null
  from_port        = 80

  protocol         = "tcp"
  to_port          = 80
}

resource "aws_security_group_rule" "ECS_of_Shomotsu_Ingress_Rule_For_Https" {
  security_group_id = var.ecs_sg_id
  source_security_group_id = var.alb_sg_id
  
  type = "ingress"
  
  description      = null
  from_port        = 443
  
  protocol         = "tcp"
  to_port          = 443
}

################################################
# Security group rule of ECS (egress)
################################################

resource "aws_security_group_rule" "ECS_of_Shomotsu_Egress_Rule_Port_0" {
  security_group_id = var.ecs_sg_id

  type = "egress"

  cidr_blocks      = [
    "0.0.0.0/0",
  ]

  description      = null
  from_port        = 0
  protocol         = "-1"
  to_port          = 0
}

resource "aws_security_group_rule" "ECS_of_Shomotsu_Egress_Rule_Port_3376" {
  security_group_id = var.ecs_sg_id
  source_security_group_id = var.rds_sg_id

  type = "egress"

  description      = null
  from_port        = 3306
  protocol         = "tcp"
  to_port          = 3306
}

resource "aws_security_group_rule" "ECS_of_Shomotsu_Egress_Rule_Port_6379" {
  security_group_id = var.ecs_sg_id
  source_security_group_id = var.elasticache_sg_id

  type = "egress"
  
  description      = null
  from_port        = 6379
  protocol         = "tcp"
  to_port          = 6379
}

################################################
# Security group rule of RDS (ingress)
################################################

resource "aws_security_group_rule" "RDS_of_Shomotsu_Ingress_Rule_For_RDS" {
  source_security_group_id = var.ecs_sg_id
  security_group_id = var.rds_sg_id
  type = "ingress"
  description      = null
  from_port        = 3306
  protocol         = "tcp"
  to_port          = 3306
}

################################################
# Security group rule of ElastiCache (ingress)
################################################

resource "aws_security_group_rule" "ElastiCache_of_Shomotsu_Ingress_Rule_For_ElastiCache_Port_6379" {
  source_security_group_id = var.ecs_sg_id
  security_group_id = var.elasticache_sg_id

  type = "ingress"
  description      = null
  from_port        = 6379
  protocol         = "tcp"
  to_port          = 6379
}

resource "aws_security_group_rule" "ElastiCache_of_Shomotsu_Ingress_Rule_For_ElastiCache_Port_6380" {
  source_security_group_id = var.ecs_sg_id
  security_group_id = var.elasticache_sg_id

  type = "ingress"
  description      = null
  from_port        = 6380
  protocol         = "tcp"
  to_port          = 6380
}