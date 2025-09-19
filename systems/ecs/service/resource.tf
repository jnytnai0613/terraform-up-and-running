############
# ALB
############

data "aws_vpc" "vpc" {
  tags = {
    Name = "${local.service_name}-${local.env}-vpc"
    Env  = local.env
  }
}

data "aws_acm_certificate" "certificate" {
  domain = local.certificate_domain
}

# ECS用Security Group作成時に、 以下エラーが発生する。
# +++++++++++++++++++
# The "for_each" map includes keys derived from resource attributes that cannot be determined until apply, and so Terraform cannot determine the full set of keys that will identify the instances of this resource.
# When working with unknown values in for_each, it's better to define the map keys statically in your configuration and place apply-time results only in the map values.
# Alternatively, you could use the -target planning option to first apply only the resources that the for_each value depends on, and then apply a second time to fully converge.
# +++++++++++++++++++
# よって最初に以下コマンドでALB用Security Groupを作成する
# terraform apply -target=module.alb_security_group
module "alb_security_group" {
  source = "../../../modules/vpc/security_group"

  service_name   = local.service_name
  service_suffix = "alb"
  env            = local.env
  vpc_id         = data.aws_vpc.vpc.id
  # 内向き通信(ingress)設定
  security_group_ingress_cidrs = [
    "0.0.0.0/0"
  ]
  # security_group_ingress_sgs = []
  # security_group_ingress_allow_self = false
  security_group_ingress_ports = [
    80,
    443
  ]

  # 外向け通信(egress)設定
  # security_group_egress_cidrs = ["0.0.0.0/0"]
  # security_group_egress_allow_self = false
}

module "alb" {
  source = "../../../modules/ecs/service/alb"

  service_name = local.service_name
  env          = local.env

  # ALB本体設定
  alb_subnet_ids = data.aws_subnets.public_subnets.ids # ALBを紐付けるサブネットID
  # ALBに付与するセキュリティグループのID
  alb_security_group_ids = [
    module.alb_security_group.security_group_id
  ]
  # alb_additional_tags = {} # モジュール内の各種リソースに付与する追加タグ

  # ログ設定
  # alb_log_transition_in_days = 90 # ログをSTANDARDからSTANDARD IAに移動するまでの日数
  # alb_log_expiration_in_days = 550 # ログを削除するまでの保管期間

  # リスナー設定(HTTPリスナー)
  # alb_enable_http_listener = true # HTTPリスナーを有効化
  # alb_enable_redirect_http_to_https = true # HTTPリスナーではHTTP -> HTTPSにリダイレクト

  # リスナー設定(HTTPSリスナー)
  # alb_enable_https_listener = true # HTTPSリスナーを有効化
  # alb_https_listener_ssl_policy = "ELBSecurityPolicy-2016-08"
  alb_https_certificate_arn = data.aws_acm_certificate.certificate.arn # HTTPSリスナーに紐付ける証明書ARNを指定

  # ターゲットグループ設定
  alb_vpc_id = data.aws_vpc.vpc.id # ターゲットグループを紐付けるVPC ID
  # alb_target_group_port = 80 # ターゲットグループの待受ポート
  # alb_target_group_health_check_port = 80 # ヘルスチェック用ポート
  # alb_target_group_health_check_path = "/" # ヘルスチェック用パス
  # alb_target_group_health_check_interval = 30 # ヘルスチェックの間隔
  # alb_target_group_health_check_timeout = 10 # ヘルスチェックのタイムアウト
  # alb_target_group_health_check_healthy_threshold = 3 # ヘルスチェック先をHealthyとみなすヘルスチェック回数
  # alb_target_group_health_check_unhealthy_threshold = 0 # ヘルスチェック先をUnhealthyとみなすヘルスチェック回数
}

############
# Route53 Zone
############
# ALBのFQDNを登録する

data "aws_route53_zone" "zone" {
  name = local.dns_hosted_zone_domain
}

resource "aws_route53_record" "record" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = local.dns_a_record
  type    = "A"

  alias {
    name                   = module.alb.alb_fqdn
    zone_id                = module.alb.alb_zone_id
    evaluate_target_health = false
  }
}

############
# ECS
############

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
    module.alb_security_group.security_group_id
  ]


  # 外向け通信(egress)設定
  # security_group_egress_cidrs = ["0.0.0.0/0"]
  # security_group_egress_allow_self = false
  # security_group_egress_sgs = []
}

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

data "aws_subnets" "public_subnets" {
  filter {
    name = "vpc-id"
    values = [
      data.aws_vpc.vpc.id
    ]
  }
  tags = {
    Env   = local.env
    Scope = "public"
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
  ecs_service_alb_target_group_arn            = module.alb.alb_target_group_arn
  ecs_service_alb_target_group_container_name = "nginx"
  # ecs_service_alb_target_group_container_port = 80

  # ECS Exec設定
  # ecs_service_enable_execute_command = false

  # デプロイ設定
  # ecs_service_deployment_controller = "ECS"

  # 追加タグ設定
  ecs_service_additional_tags = {}
}
