resource "aws_route53_record" "app_domain_records" {
  zone_id  = data.aws_route53_zone.default_domain.zone_id
  for_each = toset(var.app_domains)

  name = each.value
  type = "A"

  alias {
    name                   = data.aws_lb.eks_nlb.dns_name
    zone_id                = data.aws_lb.eks_nlb.zone_id
    evaluate_target_health = false
  }

  lifecycle {
    create_before_destroy = false
  }
}

module "backstage" {
  source                  = "./backstage"
  db_host                 = data.aws_ssm_parameter.db_cluster_endpoint.value
  db_password             = data.aws_ssm_parameter.db_cluster_password.value
  db_user                 = data.aws_ssm_parameter.db_cluster_user.value
  container_image         = "${data.aws_ecr_repository.backstage_image_repo.repository_url}:${var.image_tag}"
  github_client_id        = data.aws_ssm_parameter.github_client_id.value
  github_client_secret    = data.aws_ssm_parameter.github_client_secret.value
  github_token            = data.aws_ssm_parameter.github_token.value
  eks_cluster_name        = var.cluster_name
  eks_cluster_oidc_issuer = data.aws_eks_cluster.eks.identity[0].oidc[0].issuer
  eks_cluster_account_id  = data.aws_caller_identity.current.account_id
  app_name                = "backstage"
  service_account_name    = "backstage"
  k8s_namespace           = "backstage"
  app_host_name           = var.app_domains[0]
  app_port_number         = 7007
  environment             = var.environment
}
