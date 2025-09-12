variable "service_name" {
  description = "サービス名"
  type        = string
  default     = "sample"
}

variable "env" {
  description = "環境識別子（dev, stg, prd）"
  type        = string
  default     = "dev"
}

variable "role" {
  description = "ECRリポジトリに配置するイメージのロール（api, batch など）"
  type        = string
  default     = "web"
}

variable "github_organization_name" {
  type        = string
  description = "GitHubのOrganization名"
  default     = "jnytnai0613"
}

variable "github_repository_name" {
  type        = string
  description = "GitHubのRepository名"
  default     = "terraform-up-and-running"
}

/*
variable "managed_iam_policy_arns" {
  type        = list(string)
  description = "AWSまたはユーザ管理IAMポリシーのARNリスト"
  default     = [
    "arn:aws:iam::aws:policy/AdministratorAccess"
  ]
}
*/
