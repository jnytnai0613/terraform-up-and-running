resource "aws_ecs_service" "service" {
  name                               = local.ecs_service_name
  launch_type                        = "FARGATE"
  scheduling_strategy                = "REPLICA"
  cluster                            = var.ecs_service_cluster_arn
  task_definition                    = var.ecs_service_task_definition_arn
  desired_count                      = var.ecs_service_task_desired_count
  deployment_minimum_healthy_percent = var.ecs_service_task_minimum_percent
  deployment_maximum_percent         = var.ecs_service_task_maximum_percent
  enable_execute_command             = var.ecs_service_enable_execute_command

  network_configuration {
    subnets          = var.ecs_service_subnets
    security_groups  = var.ecs_service_security_groups
    assign_public_ip = false # パブリックIPは割り当てないようにハードコード
  }

  dynamic "load_balancer" {
    for_each = local.ecs_service_is_load_balancer_active
    content {
      target_group_arn = var.ecs_service_alb_target_group_arn
      container_name   = var.ecs_service_alb_target_group_container_name
      container_port   = var.ecs_service_alb_target_group_container_port
    }
  }

  deployment_controller {
    type = var.ecs_service_deployment_controller
  }

  # タスク定義はCDKで管理するため、Terraformからの変更は無視する
  lifecycle {
    ignore_changes = [
      # task_definition,
      # load_balancer,
    ]
  }
}
