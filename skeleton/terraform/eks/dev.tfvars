health_check_domains              = ["healthcheck.${{ values.default_rout53_zone }}"]
region                            = "${{ values.region }}"
environment                       = "dev" // TODO: update me
profile                           = "default"
namespace                         = "${{ values.iac_namespace }}"
route_53_zone                     = "${{ values.default_route53_zone }}"
availability_zones                = ["${{ values.region }}a", "${{ values.region }}b"] // TODO: update me
name                              = "${{ values.iac_name_suffix }}" // TODO: update me
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
kubernetes_namespace =  "${{ values.iac_namespace }}"
// TODO: tighten RBAC
map_additional_iam_roles = [
  {
    username = "admin",
    groups   = ["system:masters"],
    rolearn  = "arn:aws:iam::757583164619:role/sourcefuse-poc-2-admin-role"
  }
] // TODO: update me
vpc_name = "${{ values.iac_namespace }}-dev-vpc" // TODO: update me
private_subnet_names = [
  "${{ values.iac_namespace }}-dev-privatesubnet-private-${{ values.region }}a",
  "${{ values.iac_namespace }}-dev-privatesubnet-private-${{ values.region }}b"
]
public_subnet_names = [
  "${{ values.iac_namespace }}-dev-publicsubnet-public-${{ values.region }}a",
  "${{ values.iac_namespace }}-dev-publicsubnet-public-${{ values.region }}b"
]
