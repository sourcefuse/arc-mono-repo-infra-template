// TODO - make values

health_check_domains              = ["healthcheck-devops.sfrefarch.com"] // TODO: update me
region                            = "us-east-1" // TODO: update me
environment                       = "dev" // TODO: update me
profile                           = "default" // TODO: update me
namespace                         = "refarchdevops" // TODO: update me
route_53_zone                     = "sfrefarch.com" // TODO: update me
availability_zones                = ["us-east-1a", "us-east-1b"] // TODO: update me
name                              = "devops-k8s" // TODO: update me
kubernetes_version                = "1.21" // TODO: update me
oidc_provider_enabled             = true
enabled_cluster_log_types         = ["audit"]
cluster_log_retention_period      = 7
instance_types                    = ["t3.medium"]
desired_size                      = 3
max_size                          = 25
min_size                          = 3
disk_size                         = 50
kubernetes_labels                 = {}
cluster_encryption_config_enabled = true
addons = [
  {
    addon_name = "vpc-cni"
    #    addon_version            = "v1.9.1-eksbuild.1"
    addon_version            = null
    resolve_conflicts        = "NONE"
    service_account_role_arn = null
  }
]
kubernetes_namespace = "sf-ref-arch-devops" // TODO: update me
// TODO: tighten RBAC
map_additional_iam_roles = [
  {
    username = "admin",
    groups   = ["system:masters"],
    rolearn  = "arn:aws:iam::757583164619:role/sourcefuse-poc-2-admin-role"
  }
] // TODO: update me
vpc_name = "refarchdevops-dev-vpc" // TODO: update me
private_subnet_names = [
  "refarchdevops-dev-privatesubnet-private-us-east-1a", // TODO: update me
  "refarchdevops-dev-privatesubnet-private-us-east-1b" // TODO: update me
]
public_subnet_names = [
  "refarchdevops-dev-publicsubnet-public-us-east-1a", // TODO: update me
  "refarchdevops-dev-publicsubnet-public-us-east-1b" // TODO: update me
]
