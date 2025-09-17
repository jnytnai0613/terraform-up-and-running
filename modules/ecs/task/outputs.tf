output "task_definition_arn" {
  description = "タスク定義のARN"
  value       = aws_ecs_task_definition.task_definition.arn
}

output "task_family_name" {
  description = "タスク定義のファミリー名"
  value       = aws_ecs_task_definition.task_definition.family
}
