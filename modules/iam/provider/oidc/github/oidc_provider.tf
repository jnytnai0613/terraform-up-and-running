locals {
  domain = "https://token.actions.githubusercontent.com"
  //openid_provider_configuration_path = "/.well-known/openid-configuration"
  //openid_configuration_url           = "${local.domain}${local.openid_provider_configuration_path}"
}

/*
data "http" "openid_configuration" {
  url = local.openid_configuration_url
}

data "tls_certificate" "encryption_key" {
  url = jsondecode(data.http.openid_configuration.response_body).jwks_uri
}
*/

resource "aws_iam_openid_connect_provider" "github" {
  url = local.domain
  client_id_list = [
    "sts.amazonaws.com"
  ]
  /*
  現在はGitHubのOIDCプロバイダーの証明書が自動で取得されているため、
  AWS側でのSHA1フィンガープリントの登録は不要になっています。
  参考：
  - https://github.blog/changelog/2023-07-13-github-actions-oidc-integration-with-aws-no-longer-requires-pinning-of-intermediate-tls-certificates/
  - https://wandfuldays.com/articles/c7cx_y8_ycc/
  - https://zenn.dev/not75743/articles/60a8f9526ee32b
  - https://github.com/aws-actions/configure-aws-credentials/pull/764/files
  - https://github.com/hashicorp/terraform-provider-aws/pull/37255
  フィンガープリントは、"2b18947a6a9fc7764fd8b5fb18a863b0c6dac24f"に現在は置き換えられています。
  thumbprint_list = [
    data.tls_certificate.encryption_key.certificates[0].sha1_fingerprint
  ]
  */
}
