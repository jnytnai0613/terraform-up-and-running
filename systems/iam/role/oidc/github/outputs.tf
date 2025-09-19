output "oidc_github_role_arn" {
  description = "The ARN of the IAM role to be assumed by GitHub Actions."
  value       = module.aws_role_oidc_provider.iam_role_arn
}
