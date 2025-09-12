locals {
  ecs_cluster_tag = merge(
    var.cluster_additional_tags,
    {
      ServiceName = var.service_name
      Env         = var.env
    }
  )
}

resource "aws_ecs_cluster" "cluster" {
  name = "${var.service_name}-${var.env}-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  tags = local.ecs_cluster_tag
}

resource "aws_ecs_cluster_capacity_providers" "cluster_capacity_provider" {
  cluster_name       = aws_ecs_cluster.cluster.name
  capacity_providers = ["FARGATE"]
}

