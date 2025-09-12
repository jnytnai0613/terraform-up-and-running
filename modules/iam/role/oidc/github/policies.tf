data "aws_ecr_repository" "ecr" {
  name = "${var.service_name}-${var.env}-${var.role}"
}

data "aws_iam_policy_document" "ecr_push_policy" {
  statement {
    effect = "Allow"
    sid    = "ECRPush"

    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:CompleteLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:InitiateLayerUpload",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:BatchGetImage"
    ]

    resources = [data.aws_ecr_repository.ecr.arn]
  }

  statement {
    effect = "Allow"
    sid    = "ECRAuth"

    actions = [
      "ecr:GetAuthorizationToken"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "ecr_push_policy" {
  name = "${var.service_name}-${var.env}-ecr-push-policy"
  role   = aws_iam_role.role.name
  policy = data.aws_iam_policy_document.ecr_push_policy.json
}

/*
resource "aws_iam_role_policy_attachment" "attachments" {
  for_each = toset(var.managed_iam_policy_arns)

  role     = aws_iam_role.role.name
  policy_arn = each.value
}

resource "aws_iam_role_policy" "inline_policies" {
  for_each = var.inline_policy_documents

  role   = aws_iam_role.role.id
  name   = each.key
  policy = each.value
}
*/
