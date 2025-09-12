module "aws_role_oidc_provider" {
  source = "../../../../../modules/iam/role/oidc/github"

  service_name             = var.service_name
  env                      = var.env
  role                     = var.role
  github_organization_name = var.github_organization_name
  github_repository_name   = var.github_repository_name

  iam_role_additional_tags = {
    Usage = "GitHub-OIDC"
  }
}
