# 今回はTerraformでタスク定義の箱だけ作成、GitHub Actionsで書き換える運用とする。
# そのため、変数でなく、localで値を定義している。
locals {
  service_name = "sample"
  env          = "dev"

  container_definitions = jsonencode([
    {
      name      = "nginx"
      image     = "public.ecr.aws/nginx/nginx:1.21"
      cpu       = 1024
      memory    = 2048
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = module.log_group.log_group_name
          "awslogs-region"        = "ap-northeast-1"
          "awslogs-stream-prefix" = local.service_name
        }
      }
    }
  ])
}
