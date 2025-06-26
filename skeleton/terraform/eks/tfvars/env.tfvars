environment        = "/env/"
namespace          = "${{ values.namespace }}"
region             = "${{ values.region }}"
availability_zones = ["${{ values.region }}a", "${{ values.region }}b"]
vpc_cidr_block     = "${{ values.vpcCidrBlock }}"
project_name       = "${{ values.component_id }}"

route_53_zone                     = "${{ values.route53Domain }}"
name                              = "sl-k8s"
kubernetes_version                = "1.28"
oidc_provider_enabled             = true
enabled_cluster_log_types         = ["audit"]
cluster_log_retention_period      = 7
instance_types                    = ["t3.medium"]
desired_size                      = 3
max_size                          = 8
min_size                          = 3
kubernetes_labels                 = {}
cluster_encryption_config_enabled = true
addons = [
  // https://docs.aws.amazon.com/eks/latest/userguide/managing-vpc-cni.html#vpc-cni-latest-available-version
  {
    addon_name                  = "vpc-cni"
    addon_version               = null
    resolve_conflicts_on_create = "NONE"
    resolve_conflicts_on_update = "NONE"
    service_account_role_arn    = null
  },
  // https://docs.aws.amazon.com/eks/latest/userguide/managing-kube-proxy.html
  {
    addon_name                  = "kube-proxy"
    addon_version               = null
    resolve_conflicts_on_create = "NONE"
    resolve_conflicts_on_update = "NONE"
    service_account_role_arn    = null
  },
  // https://docs.aws.amazon.com/eks/latest/userguide/managing-coredns.html
  {
    addon_name                  = "coredns"
    addon_version               = null
    resolve_conflicts_on_create = "NONE"
    resolve_conflicts_on_update = "NONE"
    service_account_role_arn    = null
  },
]
kubernetes_namespace = "sf-ref-arch"
