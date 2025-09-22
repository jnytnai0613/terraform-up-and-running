<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
## Modules

No modules.
## Resources

| Name | Type |
|------|------|
| [aws_iam_role.role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.inline_policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.attachments](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | 環境識別子（dev, stg, prd） | `string` | n/a | yes |
| <a name="input_github_organization_name"></a> [github\_organization\_name](#input\_github\_organization\_name) | GitHubのOrganization名 | `string` | n/a | yes |
| <a name="input_github_repository_name"></a> [github\_repository\_name](#input\_github\_repository\_name) | GitHubのRepository名 | `string` | n/a | yes |
| <a name="input_iam_role_additional_tags"></a> [iam\_role\_additional\_tags](#input\_iam\_role\_additional\_tags) | IAMロールに付与するタグのキーと値のセット | `map(string)` | `{}` | no |
| <a name="input_inline_policy_documents"></a> [inline\_policy\_documents](#input\_inline\_policy\_documents) | ロールに付与するインラインポリシー、ポリシー名をキー、ポリシードキュメントを値とするマップ | `map(string)` | `{}` | no |
| <a name="input_managed_iam_policy_arns"></a> [managed\_iam\_policy\_arns](#input\_managed\_iam\_policy\_arns) | AWSまたはユーザ管理IAMポリシーのARNリスト | `list(string)` | `[]` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | IAMロールが関連するサービス名 | `string` | n/a | yes |
## Examples
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | 作成したIAMロールのARN |
<!-- END_TF_DOCS -->
