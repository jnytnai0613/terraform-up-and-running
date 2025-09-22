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
| [aws_iam_role.task_exec_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.task_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.task_exec_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.task_role_inline_policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.task_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.assume_role_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.task_exec_role_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | 環境識別子（dev, stg, prod） | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | サービス名 | `string` | n/a | yes |
| <a name="input_service_suffix"></a> [service\_suffix](#input\_service\_suffix) | サービス名のサフィックス(サブサービス名やコンポーネント名) | `string` | `""` | no |
| <a name="input_task_exec_role_additional_tags"></a> [task\_exec\_role\_additional\_tags](#input\_task\_exec\_role\_additional\_tags) | タスク実行ロールに追加するリソースタグ | `map(string)` | `{}` | no |
| <a name="input_task_role_additional_tags"></a> [task\_role\_additional\_tags](#input\_task\_role\_additional\_tags) | タスクロールに追加するリソースタグ | `map(string)` | `{}` | no |
| <a name="input_task_role_inline_policies"></a> [task\_role\_inline\_policies](#input\_task\_role\_inline\_policies) | タスクロールにアタッチするインラインポリシーのマップ | `map(string)` | `{}` | no |
| <a name="input_task_role_managed_policy_arns"></a> [task\_role\_managed\_policy\_arns](#input\_task\_role\_managed\_policy\_arns) | タスクロールにアタッチするマネージドポリシーのARN一覧 | `list(string)` | `[]` | no |
## Examples
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_task_exec_role_arn"></a> [task\_exec\_role\_arn](#output\_task\_exec\_role\_arn) | タスク実行ロールのARNです |
| <a name="output_task_exec_role_name"></a> [task\_exec\_role\_name](#output\_task\_exec\_role\_name) | タスク実行ロールの名前です |
| <a name="output_task_role_arn"></a> [task\_role\_arn](#output\_task\_role\_arn) | タスクロールのARNです |
| <a name="output_task_role_name"></a> [task\_role\_name](#output\_task\_role\_name) | タスクロールの名前です |
<!-- END_TF_DOCS -->
