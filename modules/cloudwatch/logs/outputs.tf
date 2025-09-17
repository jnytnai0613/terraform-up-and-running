output "log_group_name" {
  description = "ロググループ名"
  value       = aws_cloudwatch_log_group.log_group.name
}

output "log_group_arn" {
  description = "ロググループARN"
  value       = aws_cloudwatch_log_group.log_group.arn
}

output "log_group_tags" {
  description = "ロググループのタグ"
  value       = aws_cloudwatch_log_group.log_group.tags
}
