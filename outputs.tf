output "alb_dns_name" {
  description = "Public DNS name of the Application Load Balancer"
  value       = aws_lb.app.dns_name
}

output "ssm_instance_ids" {
  description = "EC2 instance IDs to connect via AWS Systems Manager Session Manager"
  value       = aws_instance.app[*].id
}

output "rds_endpoint" {
  description = "PostgreSQL endpoint"
  value       = aws_db_instance.postgres.address
}

output "s3_bucket_name" {
  description = "S3 bucket name"
  value       = aws_s3_bucket.app.bucket
}
output "app_domain" {
  description = "Application domain"
  value       = var.domain_name
}

output "https_url" {
  description = "HTTPS URL of the application"
  value       = "https://${var.domain_name}"
}