variable "service_name" {
  type        = string
  description = "IAMロールが関連するサービス名"
}

variable "env" {
  type        = string
  description = "環境識別子（dev, stg, prd）"
}

variable "role" {
  type        = string
  description = "ECRリポジトリに配置するイメージのロール（api, batch など）"
}

variable "iam_role_additional_tags" {
  type        = map(string)
  default     = {}
  description = "IAMロールに付与するタグのキーと値のセット"

  validation {
    condition = (
      length(
        setintersection(
          keys(var.iam_role_additional_tags),
          ["ServiceName", "Env"]
        )
    ) == 0)
    error_message = "Key names, ServiceName and Env in reserved. Not alowed to use them."
  }
}

variable "github_organization_name" {
  type        = string
  description = "GitHubのOrganization名" 
}

variable "github_repository_name" {
  type        = string
  description = "GitHubのRepository名"
}

variable "managed_iam_policy_arns" {
  type        = list(string)
  description = "AWSまたはユーザ管理IAMポリシーのARNリスト"
  default     = []
}

variable "inline_policy_documents" {
  type        = map(string)
  description = "ロールに付与するインラインポリシー、ポリシー名をキー、ポリシードキュメントを値とするマップ"
  default     = {}
}
