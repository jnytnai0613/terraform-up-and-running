resource "aws_ecr_repository" "repository" {
  name                 = "${var.service_name}-${var.env}-${var.role}"
  image_tag_mutability = var.image_tag_mutability
}

resource "aws_ecr_lifecycle_policy" "policy" {
  repository = aws_ecr_repository.repository.name

  policy = var.lifecycle_policy_json
}
