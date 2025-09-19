output "security_group_id" {
  description = "セキュリティグループID"
  value       = aws_security_group.security_group.id
}
