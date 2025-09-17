locals {
  task_family_name = var.service_sufix == "" ? "${var.service_name}-${var.env}-task" : "${var.service_name}-${var.service_sufix}-${var.env}-task"

  default_tags = var.service_name == "" ? {
    SericeName  = var.service_name
    Environment = var.env
    } : {
    Service       = var.service_name
    ServiceSuffix = var.service_sufix
    Environment   = var.env
  }

  task_resource_tags = merge(
    {
      Name = local.task_family_name
    },
    var.task_additional_tags,
    local.default_tags
  )
}

resource "aws_ecs_task_definition" "task_definition" {
  family = local.task_family_name
  requires_compatibilities = [
    "FARGATE"
  ]
  network_mode          = "awsvpc"
  cpu                   = var.task_cpu_allocation
  memory                = var.task_memory_allocation
  task_role_arn         = var.task_role_arn
  execution_role_arn    = var.task_exec_role_arn
  container_definitions = var.container_definitions
  tags                  = local.task_resource_tags

  lifecycle {
    ignore_changes = [
      container_definitions
    ]
  }
}
