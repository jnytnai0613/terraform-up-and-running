variable "service_name" {
  type        = string
  description = "VPCを利用するサービス名"
}

variable "env" {
  type        = string
  description = "環境識別子（dev, stg, prd）"
}

variable "cluster_additional_tags" {
  type        = map(string)
  default     = {}
  description = "EKSクラスタに付与するタグのキーと値のセット"

  validation {
    condition = (
      length(
        setintersection(
          keys(var.cluster_additional_tags),
          ["ServiceName", "Env"]
        )
    ) == 0)
    error_message = "Key names, ServiceName and Env in reserved. Not alowed to use them."
  }
}
