resource "aws_cloudwatch_log_group" "task_definition_log_group" {
  name = "/ecs/${join("-", [var.application_prefix, var.application_prefix, "task-definition-log-group"])}"
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = join("-", [var.application_prefix, var.application_prefix, "ecs-cluster"])

  tags = {
    Name = join("-", [var.application_prefix, var.application_prefix, "ecs-cluster"])
    env = var.env
    resource = "ecs_cluster"
  }
}

resource "aws_ecs_task_definition" "task_definition" {
  container_definitions    = jsonencode(
    [
      {
          command = [
            "php artisan migrate:status 2>&1 | grep -q \"Migration table not found\" && php artisan cache:clear && php artisan config:clear && php artisan config:cache && php artisan view:cache && php artisan route:cache && chown -hR laravel:laravel storage bootstrap/cache && php artisan migrate:refresh --seed --force && php-fpm && composer install --optimize-autoloader --no-dev || php artisan cache:clear && php artisan config:clear && php artisan config:cache && php artisan view:cache && php artisan route:cache && chown -hR laravel:laravel storage bootstrap/cache && php artisan migrate --force && php-fpm && composer install --optimize-autoloader --no-dev"
          ]
          entryPoint       = [
            "sh",
            "-c",
          ]
          environmentFiles = [
            {
              type  = "s3"
              value = var.env_s3_bucket_arn
            },
          ]
          secrets     = [
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
                "valueFrom" : module.rds.rds_password_ssm
              },
              {
                "name" : "APP_KEY",
                "valueFrom": data.aws_ssm_parameter.app_key.value
              }
          ]
          essential        = true
          image            = var.php_container_image
          logConfiguration = {
            logDriver     = "awslogs"
            options       = {
              awslogs-create-group  = "true"
              awslogs-group         = "/ecs/${join("-", [var.application_prefix, var.env, "php-log-group"])}"
              awslogs-region        = "ap-northeast-1"
              awslogs-stream-prefix = "ecs"
            }
          }
          name             = var.php_container_name
          portMappings     = [
            {
              containerPort = 9000
              hostPort      = 9000
              name          = "${var.php_container_name}-9000-tcp"
              protocol      = "tcp"
            },
          ]
          workingDirectory = "/var/www/html"
      },
      {
          essential        = true
          image            = var.nginx_container_image
          logConfiguration = {
            logDriver     = "awslogs"
            options       = {
                awslogs-create-group  = "true"
                awslogs-group         = "/ecs/${join("-", [var.application_prefix, var.env, "nginx-log-group"])}"
                awslogs-region        = "ap-northeast-1"
                awslogs-stream-prefix = "ecs"
            }
          }
          name             = var.nginx_container_name
          portMappings     = [
            {
              appProtocol   = "http"
              containerPort = 80
              hostPort      = 80
              name          = "${var.nginx_container_name}-80-tcp"
              protocol      = "tcp"
            },
          ]
          volumesFrom      = [
            {
              readOnly        = false
              sourceContainer = "${var.php_container_name}"
            },
          ]
      },
    ]
  )
  cpu                      = "1024"
  execution_role_arn       = var.execution_role_arn
  family                   = join("-", [var.application_prefix, var.env, "task-definition"])
  ipc_mode                 = null
  memory                   = "3072"
  network_mode             = "awsvpc"
  pid_mode                 = null
  requires_compatibilities = [
    "FARGATE",
  ]
  track_latest = true
  tags                     = {
    env = var.env
    resource = "task_definition"
  }
  task_role_arn            = var.task_role_arn

  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }
}

resource "aws_ecs_service" "service" {
  name = join("-", [var.application_prefix, var.env, "ecs-service"])
  cluster       = aws_ecs_cluster.ecs_cluster.id
  desired_count = 1
  launch_type   = "FARGATE"

  network_configuration {
    subnets = var.public_subnets
    security_groups  = var.security_groups
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name = var.nginx_container_name
    container_port = 80
  }

  lifecycle {
    create_before_destroy = true
  }

  task_definition = aws_ecs_task_definition.task_definition.arn
  tags = {
    Name = join("-", [var.application_prefix, var.env, "ecs-service"])
    resource = "ecs_service"
    env = var.env
  }
}

data "aws_ssm_parameter" "app_key" {
  name = var.app_key
}