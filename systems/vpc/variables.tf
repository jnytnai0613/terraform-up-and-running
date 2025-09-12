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

variable "vpc_cidr_block" {
  type        = string
  description = "VPCに割り当てるCIDRブロックを記述します"
  default     = "10.0.0.0/16"
}
