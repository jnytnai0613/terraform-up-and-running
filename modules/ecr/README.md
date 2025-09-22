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
| [aws_ecr_lifecycle_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.repository](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | 環境識別子（dev, stg, prd） | `string` | n/a | yes |
| <a name="input_image_tag_mutability"></a> [image\_tag\_mutability](#input\_image\_tag\_mutability) | ECRリポジトリのイメージタグの変更可否<br/>  MUTABLE: 上書き許可<br/>  IMMUTABLE: 上書き不可 | `string` | `"MUTABLE"` | no |
| <a name="input_lifecycle_policy_json"></a> [lifecycle\_policy\_json](#input\_lifecycle\_policy\_json) | リポジトリのライフサイクルポリシーをJSON形式で定義します。<br/>  デフォルト値を指定した場合は、タグのないイメージのうちプッシュから30日以上経過したイメージを削除します。<br/>  具体的な記述内容は`lifecycle_policy/default_policy.json`を参照してください。<br/>  参考: https://docs.aws.amazon.com/AmazonECR/latest/userguide/LifecyclePolicies.html | `string` | `"{\n  \"rules\": [\n    {\n      \"rulePriority\": 1,\n      \"description\": \"Expire untagged images older than 30 days\",\n      \"selection\": {\n        \"tagStatus\": \"untagged\",\n        \"countType\": \"sinceImagePushed\",\n        \"countNumber\": 30,\n        \"countUnit\": \"days\"\n      },\n      \"action\": {\n        \"type\": \"expire\"\n      }\n    }\n  ]\n}\n"` | no |
| <a name="input_role"></a> [role](#input\_role) | ECRリポジトリに配置するイメージのロール（api, batch など） | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | サービス名 | `string` | n/a | yes |
## Examples
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecr_name"></a> [ecr\_name](#output\_ecr\_name) | ECR Repository Name |
<!-- END_TF_DOCS -->