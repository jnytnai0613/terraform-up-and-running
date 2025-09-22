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
| [aws_ecs_service.service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ecs_service_additional_tags"></a> [ecs\_service\_additional\_tags](#input\_ecs\_service\_additional\_tags) | ECSサービスとその関連リソースに付与する追加リソースタグ | `map(string)` | `{}` | no |
| <a name="input_ecs_service_alb_target_group_arn"></a> [ecs\_service\_alb\_target\_group\_arn](#input\_ecs\_service\_alb\_target\_group\_arn) | ECSサービスに付与するALBターゲットグループのARN | `string` | `""` | no |
| <a name="input_ecs_service_alb_target_group_container_name"></a> [ecs\_service\_alb\_target\_group\_container\_name](#input\_ecs\_service\_alb\_target\_group\_container\_name) | ECSサービスでALBのターゲットグループでターゲットにするコンテナの名前を指定します。<br/>コンテナの名前はタスク定義の中に含まれるものを指定します。 | `string` | `""` | no |
| <a name="input_ecs_service_alb_target_group_container_port"></a> [ecs\_service\_alb\_target\_group\_container\_port](#input\_ecs\_service\_alb\_target\_group\_container\_port) | ecs\_service\_alb\_target\_group\_container\_nameでリッスンしているポート番号を指定します。 | `string` | `80` | no |
| <a name="input_ecs_service_cluster_arn"></a> [ecs\_service\_cluster\_arn](#input\_ecs\_service\_cluster\_arn) | ECSサービスが所属するECSクラスタのARN | `string` | n/a | yes |
| <a name="input_ecs_service_deployment_controller"></a> [ecs\_service\_deployment\_controller](#input\_ecs\_service\_deployment\_controller) | ECSサービスのデプロイに利用するコントローラ設定 | `string` | `"ECS"` | no |
| <a name="input_ecs_service_enable_execute_command"></a> [ecs\_service\_enable\_execute\_command](#input\_ecs\_service\_enable\_execute\_command) | ECS Execの有効化の有無 | `bool` | `false` | no |
| <a name="input_ecs_service_security_groups"></a> [ecs\_service\_security\_groups](#input\_ecs\_service\_security\_groups) | ECSサービスに付与するセキュリティグループIDのリスト | `list(string)` | n/a | yes |
| <a name="input_ecs_service_subnets"></a> [ecs\_service\_subnets](#input\_ecs\_service\_subnets) | ECSサービスの所属するサブネットIDのリスト | `list(string)` | n/a | yes |
| <a name="input_ecs_service_task_definition_arn"></a> [ecs\_service\_task\_definition\_arn](#input\_ecs\_service\_task\_definition\_arn) | ECSサービスで実行するECSタスク定義のARN | `string` | n/a | yes |
| <a name="input_ecs_service_task_desired_count"></a> [ecs\_service\_task\_desired\_count](#input\_ecs\_service\_task\_desired\_count) | ECSサービスで実行するECSタスクの希望多重度 | `number` | `3` | no |
| <a name="input_ecs_service_task_maximum_percent"></a> [ecs\_service\_task\_maximum\_percent](#input\_ecs\_service\_task\_maximum\_percent) | ECSサービスで実行するECSタスクの希望多重度(ecs\_service\_task\_desired\_count)に対して<br/>最大で何%までのタスク実行を許容するか？ | `number` | `200` | no |
| <a name="input_ecs_service_task_minimum_percent"></a> [ecs\_service\_task\_minimum\_percent](#input\_ecs\_service\_task\_minimum\_percent) | ECSサービスで実行するECSタスクの希望多重度(ecs\_service\_task\_desired\_count)に対して<br/>最小で何%までのタスク実行を許容するか？ | `number` | `100` | no |
| <a name="input_env"></a> [env](#input\_env) | 環境識別子(dev, stg, prod)など | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | ECSサービスではなく、ECSサービスが構成する広義のサービス名 | `string` | n/a | yes |
| <a name="input_service_suffix"></a> [service\_suffix](#input\_service\_suffix) | サービス名のサフィックス | `string` | `""` | no |
## Examples
## Outputs

No outputs.
<!-- END_TF_DOCS -->
