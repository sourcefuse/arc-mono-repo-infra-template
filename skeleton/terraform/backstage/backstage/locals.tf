locals {
  oidc_issuer_stripped = replace(var.eks_cluster_oidc_issuer, "https://", "", )
  namespace            = var.k8s_namespace
  container_image      = var.container_image
  service_name         = var.app_name
  port_number          = var.app_port_number
  host_name            = var.app_host_name
  secret_name          = "${var.environment}-${var.app_name}"
}
