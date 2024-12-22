resource "aws_ecr_repository" "ecr" {
  for_each = var.repositories

  name = join("-", [var.application_prefix, var.env, each.value.name])
  image_tag_mutability = each.value.image_tag_mutability
  image_scanning_configuration {
    scan_on_push = each.value.image_scanning_configuration.scan_on_push
  }

  tags = {
    Name = join("-", [var.application_prefix, var.env, each.value.name])
    resource = "ecr"
    env = var.env
  }
}