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
| [aws_cloudwatch_log_group.log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | 環境識別子（dev, stg, prod） | `string` | n/a | yes |
| <a name="input_log_group_additional_tags"></a> [log\_group\_additional\_tags](#input\_log\_group\_additional\_tags) | ロググループに付与する追加タグです | `map(string)` | `{}` | no |
| <a name="input_log_retention_in_days"></a> [log\_retention\_in\_days](#input\_log\_retention\_in\_days) | ロググループにログを保持する期間です | `number` | `30` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | サービス名 | `string` | n/a | yes |
| <a name="input_service_suffix"></a> [service\_suffix](#input\_service\_suffix) | サービス名のサフィックス(サブサービス名やコンポーネント名) | `string` | `""` | no |
## Examples
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_log_group_arn"></a> [log\_group\_arn](#output\_log\_group\_arn) | ロググループARN |
| <a name="output_log_group_name"></a> [log\_group\_name](#output\_log\_group\_name) | ロググループ名 |
| <a name="output_log_group_tags"></a> [log\_group\_tags](#output\_log\_group\_tags) | ロググループのタグ |
<!-- END_TF_DOCS -->
