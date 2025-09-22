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
| [aws_ecs_task_definition.task_definition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_definitions"></a> [container\_definitions](#input\_container\_definitions) | タスクを構成するさまざまなコンテナを説明するJSON形式のコンテナ定義のリスト。 | `string` | `"[\n    {\n        \"name\": \"nginx\",\n        \"image\": \"nginx:latest\",\n        \"cpu\": 1024,\n        \"memory\": 2048,\n        \"essential\": true,\n        \"portMappings\": [\n            {\n                \"containerPort\": 80,\n                \"hostPort\": 80\n            }\n        ]\n    }\n]\n"` | no |
| <a name="input_env"></a> [env](#input\_env) | 環境識別子(dev, staging, prodなど) | `string` | `"dev"` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | サービス名 | `string` | n/a | yes |
| <a name="input_service_sufix"></a> [service\_sufix](#input\_service\_sufix) | Service Suffix（サブサービス名やコンポーネント名など) | `string` | `""` | no |
| <a name="input_task_additional_tags"></a> [task\_additional\_tags](#input\_task\_additional\_tags) | タスク定義に追加するタグのマップ | `map(string)` | `{}` | no |
| <a name="input_task_cpu_allocation"></a> [task\_cpu\_allocation](#input\_task\_cpu\_allocation) | タスクのCPU割り当て(1024 = 1 vCPU) | `number` | `1024` | no |
| <a name="input_task_exec_role_arn"></a> [task\_exec\_role\_arn](#input\_task\_exec\_role\_arn) | Amazon ECSコンテナエージェントとDockerデーモンが引き受けることができるタスク実行ロールのARN。 | `string` | n/a | yes |
| <a name="input_task_memory_allocation"></a> [task\_memory\_allocation](#input\_task\_memory\_allocation) | タスクのメモリ割り当て(MB単位) | `number` | `2048` | no |
| <a name="input_task_role_arn"></a> [task\_role\_arn](#input\_task\_role\_arn) | タスク内のコンテナが引き受けることができるIAMロールのARN。 | `string` | n/a | yes |
## Examples
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_task_definition_arn"></a> [task\_definition\_arn](#output\_task\_definition\_arn) | タスク定義のARN |
| <a name="output_task_family_name"></a> [task\_family\_name](#output\_task\_family\_name) | タスク定義のファミリー名 |
<!-- END_TF_DOCS -->
