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
}

data "aws_iam_policy_document" "ecr_auth_policy" {
  statement {
    effect = "Allow"
    sid    = "ECRAuth"

    actions = [
      "ecr:GetAuthorizationToken"
    ]

    resources = ["*"]
  }
}

module "aws_role_oidc_provider" {
  source = "../../../../../modules/iam/role/oidc/github"

  service_name             = var.service_name
  env                      = var.env
  github_organization_name = var.github_organization_name
  github_repository_name   = var.github_repository_name

  inline_policy_documents = {
    ECRAuth            = data.aws_iam_policy_document.ecr_auth_policy.json
    PushContainerImage = data.aws_iam_policy_document.ecr_push_policy.json
  }

  iam_role_additional_tags = {
    Usage = "GitHub-OIDC"
  }
}
