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
