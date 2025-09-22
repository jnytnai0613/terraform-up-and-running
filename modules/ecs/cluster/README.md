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
| [aws_ecs_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_cluster_capacity_providers.cluster_capacity_provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster_capacity_providers) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_additional_tags"></a> [cluster\_additional\_tags](#input\_cluster\_additional\_tags) | EKSクラスタに付与するタグのキーと値のセット | `map(string)` | `{}` | no |
| <a name="input_env"></a> [env](#input\_env) | 環境識別子（dev, stg, prd） | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | VPCを利用するサービス名 | `string` | n/a | yes |
## Examples
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | ECS Cluster ARN |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | ECS Cluster Name |
<!-- END_TF_DOCS -->
