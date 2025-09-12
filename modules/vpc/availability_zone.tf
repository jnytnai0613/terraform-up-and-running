locals {
  # 利用可能かつ除外されていないアベイラビリティゾーンの数
  number_of_availability_zones = length(data.aws_availability_zones.availability_zones.names)
}

data "aws_availability_zones" "availability_zones" {
  state = "available"

  # すでにobsoluteになっているAZ（ap-northeast-1b）を除外する
  exclude_names = [
    "ap-northeast-1b"
  ]
}
