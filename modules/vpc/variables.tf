variable "vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "VPCに割り当てるCIDRブロックを記述します"

  validation {
    condition     = can(regex("\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}/\\d{1,2}", var.vpc_cidr_block))
    error_message = "Specify VPC CIDR block with the CIDR format"
  }
}

variable "service_name" {
  type        = string
  description = "VPCを利用するサービス名"
}

variable "env" {
  type        = string
  description = "環境識別子（dev, stg, prd）"
}

variable "vpc_additional_tags" {
  type        = map(string)
  default     = {}
  description = "VPCに付与するタグのキーと値のセット"

  validation {
    condition = (
      length(
        setintersection(
          keys(var.vpc_additional_tags),
          ["Name", "Env"]
        )
    ) == 0)
    error_message = "Key names, Name and Env in reserved. Not alowed to use them."
  }
}

variable "subnet_cidrs" {
  description = "サブネットごとのcidr指定"
  type = object({
    public  = list(string)
    private = list(string)
  })

  validation {
    condition = length(setintersection([
      for cidr in var.subnet_cidrs.public : (can(
        regex("^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}/\\d{1,2}", cidr)
      ) ? cidr : null)
      ],
    var.subnet_cidrs.public)) == length(var.subnet_cidrs.public)
    error_message = "Specify VPC Public Subnet CIDR block with the CIDR format."
  }

  validation {
    condition = length(setintersection([
      for cidr in var.subnet_cidrs.private : (can(
        regex("^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}/\\d{1,2}", cidr)
      ) ? cidr : null)
      ],
    var.subnet_cidrs.private)) == length(var.subnet_cidrs.private)
    error_message = "Specify VPC Private Subnet CIDR block with the CIDR format."
  }

  validation {
    condition     = length(var.subnet_cidrs.public) >= 2
    error_message = "At least two public subnets are required."
  }

  validation {
    condition     = length(var.subnet_cidrs.private) >= 2
    error_message = "At least two private subnets are required."
  }

  validation {
    condition     = length(var.subnet_cidrs.public) == length(var.subnet_cidrs.private)
    error_message = "The number of public subnets and private subnets must be the same."
  }
}

variable "subnet_additional_tags" {
  type        = map(string)
  default     = {}
  description = "サブネットに付与するタグのキーと値のセット"

  validation {
    condition = (
      length(
        setintersection(
          keys(var.subnet_additional_tags),
          ["Name", "Env", "AvailabilityZone", "Scope"]
        )
    ) == 0)
    error_message = "Key names, Name and Env, AvailabilityZone and Scope in reserved. Not alowed to use them."
  }
}

variable "igw_additional_tags" {
  type        = map(string)
  default     = {}
  description = "インターネットゲートウェイに付与するタグのキーと値のセット"

  validation {
    condition = (
      length(
        setintersection(
          keys(var.igw_additional_tags),
          ["Name", "Env", "VpcId"]
        )
    ) == 0)
    error_message = "Key names, Name and Env, VpcId in reserved. Not alowed to use them."
  }
}
