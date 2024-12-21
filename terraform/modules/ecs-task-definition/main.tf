resource "aws_ecs_task_definition" "shomotsu_task_definition" {
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
              value = var.env_s3
            },
          ]
          secrets     = var.secrets
          essential        = true
          image            = var.laravel_container_image
          logConfiguration = {
            logDriver     = "awslogs"
            options       = {
              awslogs-create-group  = "true"
              awslogs-group         = "/ecs/${var.family_name}"
              awslogs-region        = "ap-northeast-1"
              awslogs-stream-prefix = "ecs"
            }
          }
          name             = "${var.laravel_container_name}"
          portMappings     = [
            {
              containerPort = 9000
              hostPort      = 9000
              name          = "${var.laravel_container_name}-9000-tcp"
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
                awslogs-group         = "/ecs/${var.family_name}"
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
              sourceContainer = "${var.laravel_container_name}"
            },
          ]
      },
    ]
  )
  cpu                      = "1024"
  execution_role_arn       = var.execution_role_arn
  family                   = var.family_name
  ipc_mode                 = null
  memory                   = "3072"
  network_mode             = "awsvpc"
  pid_mode                 = null
  requires_compatibilities = [
    "FARGATE",
  ]
  track_latest = true
  tags                     = var.tags
  task_role_arn            = var.task_role_arn

  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }
}