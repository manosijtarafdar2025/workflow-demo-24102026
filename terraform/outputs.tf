output "ecr_repository_name" {
  description = "Name of the ECR repository"
  value       = aws_ecr_repository.python_app.name
}

output "ecr_repository_url" {
  description = "URL used to tag and push Docker images"
  value       = aws_ecr_repository.python_app.repository_url
}

output "ecr_repository_arn" {
  description = "ARN of the ECR repository"
  value       = aws_ecr_repository.python_app.arn
}
