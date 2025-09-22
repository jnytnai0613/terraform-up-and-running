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
| [aws_security_group.security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.ingess_cidr_security_group_rules](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_sg_security_group_rules](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.security_group_rule_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.security_group_rule_egress_sgs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | 環境識別子(dev, stg, prod)など | `string` | n/a | yes |
| <a name="input_security_group_additional_tags"></a> [security\_group\_additional\_tags](#input\_security\_group\_additional\_tags) | セキュリティグループに追加で付与するリソースタグです | `map(string)` | `{}` | no |
| <a name="input_security_group_egress_allow_self"></a> [security\_group\_egress\_allow\_self](#input\_security\_group\_egress\_allow\_self) | 外向け通信(egress)の宛先セキュリティグループとして自身のSGを許可するか否かです | `bool` | `false` | no |
| <a name="input_security_group_egress_cidrs"></a> [security\_group\_egress\_cidrs](#input\_security\_group\_egress\_cidrs) | 外向け通信(egress)として許可するCIDRのリストです | `list(string)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_security_group_egress_sgs"></a> [security\_group\_egress\_sgs](#input\_security\_group\_egress\_sgs) | 外向け通信(egress)との送信元セキュリティグループとして許可するセキュリティグループIDのリストです | `list(string)` | `[]` | no |
| <a name="input_security_group_ingress_allow_self"></a> [security\_group\_ingress\_allow\_self](#input\_security\_group\_ingress\_allow\_self) | 内向き通信として自身のセキュリティグループを許可するかどうか | `bool` | `false` | no |
| <a name="input_security_group_ingress_cidrs"></a> [security\_group\_ingress\_cidrs](#input\_security\_group\_ingress\_cidrs) | 内向き通信として許可するCIDのリスト | `list(string)` | `[]` | no |
| <a name="input_security_group_ingress_ports"></a> [security\_group\_ingress\_ports](#input\_security\_group\_ingress\_ports) | 内向き通信として許可するポート番号のリスト | `list(number)` | <pre>[<br/>  80<br/>]</pre> | no |
| <a name="input_security_group_ingress_sgs"></a> [security\_group\_ingress\_sgs](#input\_security\_group\_ingress\_sgs) | 内向き通信との送信元セキュリティグループとして許可するセキュリティグループIDのリスト | `list(string)` | `[]` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | サービス名 | `string` | n/a | yes |
| <a name="input_service_suffix"></a> [service\_suffix](#input\_service\_suffix) | サービス名のサフィックス(用途、サブサービス名、コンポーネント名など) | `string` | `""` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | セキュリティグループが所属するVPC ID | `string` | n/a | yes |
## Examples
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | セキュリティグループID |
<!-- END_TF_DOCS -->
