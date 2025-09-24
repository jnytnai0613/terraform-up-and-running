locals {
  service_name = "sample"
  env          = "dev"

  ecs_cluster_name = "${local.service_name}-${local.env}-cluster"
  ecs_task_family  = "${local.service_name}-${local.env}-task"
}
