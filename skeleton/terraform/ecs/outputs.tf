output "cluster_name" {
  description = "Name of the ECS Cluster"
  value       = module.ecs.ecs_cluster_name
}