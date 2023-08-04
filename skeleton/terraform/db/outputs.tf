output "db_admin_username" {
  description = "DB Admin username to the SQL Server"
  value       = var.db_admin_username
}

## aurora
output "aurora_endpoint" {
  value       = try(module.aurora[0].endpoint, null)
  description = "The DNS address of the Aurora instance"
}

output "aurora_arn" {
  value       = try(module.aurora[0].arn, null)
  description = "Amazon Resource Name (ARN) of cluster"
}
