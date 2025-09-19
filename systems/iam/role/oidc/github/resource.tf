data "aws_ecr_repository" "ecr" {
  name = "${var.service_name}-${var.env}-${var.role}"
}

data "aws_ecs_cluster" "ecs_cluster" {
  cluster_name = "${var.service_name}-${var.env}-cluster"
}

data "aws_ecs_service" "ecs_service" {
  cluster_arn  = data.aws_ecs_cluster.ecs_cluster.id
  service_name = "${var.service_name}-${var.env}-service"
}

data "aws_ecs_task_definition" "task_definition" {
  task_definition = "${var.service_name}-${var.env}-task"
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

    resources = [
      data.aws_ecr_repository.ecr.arn
    ]
  }
}

data "aws_iam_policy_document" "ecr_auth_policy" {
  statement {
    effect = "Allow"
    sid    = "ECRAuth"

    actions = [
      "ecr:GetAuthorizationToken"
    ]

    resources = [
      "*"
    ]
  }
}

data "aws_iam_policy_document" "ecr_pull_policy" {
  statement {
    effect = "Allow"
    sid    = "ECRPull"

    actions = [
      "ecr:BatchGetImage",
      "ecr:DescribeImages",
      "ecr:GetDownloadUrlForLayer"
    ]

    resources = [
      data.aws_ecr_repository.ecr.arn
    ]
  }
}

data "aws_iam_policy_document" "deploy_service" {
  statement {
    effect = "Allow"
    sid    = "RegisterTaskDefinition"

    actions = [
      "ecs:RegisterTaskDefinition",
    ]

    resources = [
      "*"
    ]
  }

  statement {
    effect = "Allow"
    sid    = "DescribeTaskDefinition"

    actions = [
      "ecs:DescribeTaskDefinition",
    ]

    resources = [
      "*"
    ]
  }

  statement {
    effect = "Allow"
    sid    = "DeployService"

    actions = [
      "ecs:UpdateService",
      "ecs:DescribeServices",
    ]

    resources = [
      data.aws_ecs_service.ecs_service.arn
    ]
  }

  statement {
    effect = "Allow"
    sid    = "PassRoleInTaskExecution"

    actions = [
      "iam:PassRole"
    ]

    resources = [
      data.aws_ecs_task_definition.task_definition.execution_role_arn,
      data.aws_ecs_task_definition.task_definition.task_role_arn
    ]
  }

  statement {
    effect = "Allow"
    sid    = "TagResourceOnTaskDefinition"

    actions = [
      "ecs:TagResource"
    ]

    resources = [
      "${data.aws_ecs_task_definition.task_definition.arn_without_revision}:*"
    ]
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
    PullContainerImage = data.aws_iam_policy_document.ecr_pull_policy.json
    DeployService      = data.aws_iam_policy_document.deploy_service.json
  }

  iam_role_additional_tags = {
    Usage = "GitHub-OIDC"
  }
}
