variable "service_name" {
  type        = string
  description = "サービス名"
}

variable "env" {
  type        = string
  description = "環境識別子（dev, stg, prd）"
}

variable "role" {
  type        = string
  description = "ECRリポジトリに配置するイメージのロール（api, batch など）"
}

variable "image_tag_mutability" {
  type        = string
  description = <<DESC
  ECRリポジトリのイメージタグの変更可否
  MUTABLE: 上書き許可
  IMMUTABLE: 上書き不可
DESC
  default     = "MUTABLE"
}

variable "lifecycle_policy_json" {
  type        = string
  description = <<ESC
  リポジトリのライフサイクルポリシーをJSON形式で定義します。
  デフォルト値を指定した場合は、タグのないイメージのうちプッシュから30日以上経過したイメージを削除します。
  具体的な記述内容は`lifecycle_policy/default_policy.json`を参照してください。
  参考: https://docs.aws.amazon.com/AmazonECR/latest/userguide/LifecyclePolicies.html
ESC
  default     = <<POLICY
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Expire untagged images older than 30 days",
      "selection": {
        "tagStatus": "untagged",
        "countType": "sinceImagePushed",
        "countNumber": 30,
        "countUnit": "days"
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
POLICY
}
