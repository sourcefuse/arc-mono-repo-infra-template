resource "aws_route53_record" "app_domain_records" {
  zone_id = data.aws_route53_zone.default_domain.zone_id

  name = local.host_name
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


// TODO: convert to variables
locals {
  namespace    = "pgadmin"
  docker_image = "dpage/pgadmin4"
  service_name = "pgadmin-svc"
  host_name    = "pgadmin-devops.${var.route_53_zone}"
  port_number  = "80"
}

resource "kubernetes_namespace" "pgadmin" {
  metadata {
    annotations = {
      name = local.namespace
    }

    labels = {
      name = local.namespace
    }

    name = local.namespace
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "random_password" "pg_admin_admin_password" {
  length = 32
}

module "pgadmin_applications" {
  source          = "git@github.com:sourcefuse/terraform-k8s-app.git"
  app_label       = local.namespace
  container_image = local.docker_image
  container_name  = local.namespace
  container_port  = local.port_number
  deployment_name = local.namespace
  namespace_name  = kubernetes_namespace.pgadmin.metadata[0].name
  port            = local.port_number
  port_name       = local.port_number
  protocol        = "TCP"
  service_name    = local.service_name
  target_port     = 80
  replica_count   = 1
  // TODO: refactor to use secrets
  environment_variables = [
    {
      name  = "PGADMIN_DEFAULT_EMAIL"
      value = "sfdevops@sourcefuse.com"
    },
    {
      name  = "PGADMIN_DEFAULT_PASSWORD"
      value = random_password.pg_admin_admin_password.result
    }
  ]
}

module "ingress" {
  source       = "../ingress"
  host_name    = local.host_name
  service_name = local.service_name
  namespace    = local.namespace
  port_number  = local.port_number
}
