/*
  aws_ecs_cluster dataソースからARNを取得してECSサービスモジュールの呼び出しに渡す。
  aws_caller_identity dataソースと、ARNルールを組み合わせてECSクラスターのARNを生成しても良い
*/
data "aws_ecs_cluster" "cluster" {
  cluster_name = local.ecs_cluster_name
}

data "aws_ecs_task_definition" "task_definition" {
  task_definition = local.ecs_task_family
}

data "aws_vpc" "vpc" {
  tags = {
    Name = "${local.service_name}-${local.env}-vpc"
    Env  = local.env
  }
}

data "aws_subnets" "private_subnets" {
  filter {
    name = "vpc-id"
    values = [
      data.aws_vpc.vpc.id
    ]
  }
  tags = {
    Env   = local.env
    Scope = "private"
  }
}

data "aws_security_group" "alb_security_group" {
  filter {
    name = "group-name"
    values = [
      "${local.service_name}-alb-${local.env}-sg"
    ]
  }
  filter {
    name = "vpc-id"
    values = [
      data.aws_vpc.vpc.id
    ]
  }
}

data "aws_alb_target_group" "alb_target_group" {
  name = "${local.service_name}-${local.env}-alb-tg"
}

module "ecs_security_group" {
  source = "../../../modules/vpc/security_group"

  service_name   = local.service_name
  service_suffix = "ecs"
  env            = local.env
  vpc_id         = data.aws_vpc.vpc.id

  # 内向き通信(ingress)設定
  security_group_ingress_cidrs = [
    # "0.0.0.0/0"
  ]
  security_group_ingress_ports = [
    80
  ]
  security_group_ingress_sgs = [
    data.aws_security_group.alb_security_group.id
  ]


  # 外向け通信(egress)設定
  # security_group_egress_cidrs = ["0.0.0.0/0"]
  # security_group_egress_allow_self = false
  # security_group_egress_sgs = []
}

module "ecs_service" {
  source       = "../../../modules/ecs/service"
  service_name = local.service_name
  # service_suffix = ""
  env = local.env

  # サービス設定
  ecs_service_cluster_arn = data.aws_ecs_cluster.cluster.arn
  # ecs_service_task_desired_count = 3
  # ecs_service_task_maximum_percent = 200
  # ecs_service_task_minimum_percent = 100

  # サービスネットワーク設定
  ecs_service_subnets = data.aws_subnets.private_subnets.ids
  ecs_service_security_groups = [
    module.ecs_security_group.security_group_id
  ]
  ecs_service_task_definition_arn = data.aws_ecs_task_definition.task_definition.arn_without_revision

  # ロードバランサ設定
  ecs_service_alb_target_group_arn            = data.aws_alb_target_group.alb_target_group.arn
  ecs_service_alb_target_group_container_name = "nginx"
  # ecs_service_alb_target_group_container_port = 80

  # ECS Exec設定
  # ecs_service_enable_execute_command = false

  # デプロイ設定
  # ecs_service_deployment_controller = "ECS"

  # 追加タグ設定
  ecs_service_additional_tags = {}
}
