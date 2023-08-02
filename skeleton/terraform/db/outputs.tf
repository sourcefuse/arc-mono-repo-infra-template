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

# ## sqlserver
# output "rds_sql_server_endpoint" {
#   description = "Endpoint address to the RDS Instance"
#   value       = try(module.rds_sql_server[0].rds_instance_endpoint, null)
# }

# output "rds_sql_server_arn" {
#   description = "ARN of the RDS Instance."
#   value       = try(module.rds_sql_server[0].rds_instance_arn, null)
# }
