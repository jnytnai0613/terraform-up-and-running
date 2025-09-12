output "ecr_name" {
  description = "ECR Repository Name"
  value       = aws_ecr_repository.repository.name
}
