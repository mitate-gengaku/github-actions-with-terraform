resource "aws_ecr_repository" "shomotsu_ecr" {
  for_each = var.repositories

  name = each.value.name
  tags = each.value.tags
  image_tag_mutability = each.value.image_tag_mutability
  image_scanning_configuration {
    scan_on_push = each.value.image_scanning_configuration.scan_on_push
  }
}
