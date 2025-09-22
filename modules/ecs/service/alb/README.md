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
| [aws_alb_listener.http_listener_forward](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener) | resource |
| [aws_alb_listener.https_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener) | resource |
| [aws_alb_listener.https_listener_redirect](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener) | resource |
| [aws_alb_target_group.target_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_target_group) | resource |
| [aws_lb.alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_s3_bucket.log_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_lifecycle_configuration.log_bucket_lifecycle](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_policy.log_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.log_bucket_public_access_block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.log_bucket_sse_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_iam_policy_document.log_bucket_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_additional_tags"></a> [alb\_additional\_tags](#input\_alb\_additional\_tags) | ALBとその関連リソースに付与する追加リソースタグ | `map(string)` | `{}` | no |
| <a name="input_alb_enable_http_listener"></a> [alb\_enable\_http\_listener](#input\_alb\_enable\_http\_listener) | ALBのHTTPリスナーを有効にするか否かを指定します | `bool` | `true` | no |
| <a name="input_alb_enable_https_listener"></a> [alb\_enable\_https\_listener](#input\_alb\_enable\_https\_listener) | ALBのHTTPSリスナーを有効にするか否かを指定します | `bool` | `true` | no |
| <a name="input_alb_enable_redirect_http_to_https"></a> [alb\_enable\_redirect\_http\_to\_https](#input\_alb\_enable\_redirect\_http\_to\_https) | ALBのHTTPリスナーからHTTPSへとリダイレクトするか否かを指定します。<br/>alb\_listener\_enable\_httpが有効(true)な場合のみ有効です。 | `bool` | `true` | no |
| <a name="input_alb_https_certificate_arn"></a> [alb\_https\_certificate\_arn](#input\_alb\_https\_certificate\_arn) | ALBのHTTPリスナーに付与するSSL/TLS証明書のARN | `string` | `""` | no |
| <a name="input_alb_https_listener_ssl_policy"></a> [alb\_https\_listener\_ssl\_policy](#input\_alb\_https\_listener\_ssl\_policy) | ALBのHTTPリスナーのSSLポリシーを指定します | `string` | `"ELBSecurityPolicy-2016-08"` | no |
| <a name="input_alb_log_expiration_in_days"></a> [alb\_log\_expiration\_in\_days](#input\_alb\_log\_expiration\_in\_days) | ALBのログをS3に保管した後、削除するまでの期間 | `number` | `550` | no |
| <a name="input_alb_log_transition_in_days"></a> [alb\_log\_transition\_in\_days](#input\_alb\_log\_transition\_in\_days) | ALBのログをS3に保管した後標準IAに移行するまでの期間 | `number` | `90` | no |
| <a name="input_alb_security_group_ids"></a> [alb\_security\_group\_ids](#input\_alb\_security\_group\_ids) | ALBに付与するセキュリティグループIDのリスト | `list(string)` | `[]` | no |
| <a name="input_alb_subnet_ids"></a> [alb\_subnet\_ids](#input\_alb\_subnet\_ids) | ALBを配置するサブネットIDのリスト | `list(string)` | n/a | yes |
| <a name="input_alb_target_group_health_check_healthy_threshold"></a> [alb\_target\_group\_health\_check\_healthy\_threshold](#input\_alb\_target\_group\_health\_check\_healthy\_threshold) | ヘルスチェック先をHealthyと判断するヘルスチェック回数 | `number` | `3` | no |
| <a name="input_alb_target_group_health_check_interval"></a> [alb\_target\_group\_health\_check\_interval](#input\_alb\_target\_group\_health\_check\_interval) | ターゲットグループのヘルスチェック間隔(秒) | `number` | `30` | no |
| <a name="input_alb_target_group_health_check_path"></a> [alb\_target\_group\_health\_check\_path](#input\_alb\_target\_group\_health\_check\_path) | ターゲットグループのヘルスチェックに使うパス | `string` | `"/"` | no |
| <a name="input_alb_target_group_health_check_port"></a> [alb\_target\_group\_health\_check\_port](#input\_alb\_target\_group\_health\_check\_port) | ターゲットグループのヘルスチェック用ポート番号指定<br/>指定しない場合は、alb\_target\_group\_portと同じ番号を指定 | `number` | `0` | no |
| <a name="input_alb_target_group_health_check_timeout"></a> [alb\_target\_group\_health\_check\_timeout](#input\_alb\_target\_group\_health\_check\_timeout) | ターゲットグループのヘルスチェックのタイムアウト(秒) | `number` | `10` | no |
| <a name="input_alb_target_group_health_check_unhealthy_threshold"></a> [alb\_target\_group\_health\_check\_unhealthy\_threshold](#input\_alb\_target\_group\_health\_check\_unhealthy\_threshold) | ヘルスチェック先をUnhealthyと判断するヘルスチェック回数<br/>指定しない場合はalb\_target\_group\_health\_check\_healthy\_thresholdの値を利用します | `number` | `0` | no |
| <a name="input_alb_target_group_port"></a> [alb\_target\_group\_port](#input\_alb\_target\_group\_port) | ターゲットグループの待受ポート番号 | `number` | `80` | no |
| <a name="input_alb_vpc_id"></a> [alb\_vpc\_id](#input\_alb\_vpc\_id) | ALBを配置するVPC ID、ターゲットグループ設定に必要 | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | 環境識別子(dev, stg, prod)など | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | サービス名 | `string` | n/a | yes |
| <a name="input_service_suffix"></a> [service\_suffix](#input\_service\_suffix) | サービス名のサフィックス | `string` | `""` | no |
## Examples
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_arn"></a> [alb\_arn](#output\_alb\_arn) | ALBのARN |
| <a name="output_alb_fqdn"></a> [alb\_fqdn](#output\_alb\_fqdn) | ALBに付与されたFQDNです |
| <a name="output_alb_name"></a> [alb\_name](#output\_alb\_name) | ALBの名前 |
| <a name="output_alb_tags"></a> [alb\_tags](#output\_alb\_tags) | ALBに付与されているタグ |
| <a name="output_alb_target_group_arn"></a> [alb\_target\_group\_arn](#output\_alb\_target\_group\_arn) | ALBに付与されたターゲットグループのARN |
| <a name="output_alb_zone_id"></a> [alb\_zone\_id](#output\_alb\_zone\_id) | ALBのホステッドゾーンIDです。<br/>Route53でエイリアスレコードを作成する際に利用します。 |
<!-- END_TF_DOCS -->