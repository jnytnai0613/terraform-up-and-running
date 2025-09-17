module "task" {
  source = "../../../modules/ecs/task"

  service_name          = local.service_name
  env                   = local.env
  task_role_arn         = module.roles.task_role_arn
  task_exec_role_arn    = module.roles.task_exec_role_arn
  container_definitions = local.container_definitions
}

module "roles" {
  source = "../../../modules/ecs/iam/roles"

  service_name = local.service_name
  env          = local.env
  #task_exec_role_additional_tags = {}
  #task_role_managed_policy_arns = []
  #task_role_inline_policies = {}
}

module "log_group" {
  source = "../../../modules/cloudwatch/logs"

  service_name = local.service_name
  env          = local.env
  #service_suffix = ""
  #log_retention_in_days = 30
  #log_group_additional_tags = {}
}
