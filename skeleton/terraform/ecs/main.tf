################################################################################
## defaults
################################################################################
terraform {
  required_version = "~> 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {}
}

module "terraform-aws-arc-tags" {
  source      = "sourcefuse/arc-tags/aws"
  version     = "1.2.5"
  environment = var.environment
  project     = var.project_name

  extra_tags = {
    MonoRepo     = "True"
    MonoRepoPath = "terraform/ecs"
  }
}

################################################################################
## locals
################################################################################
locals {
  route_53_zone       = trimprefix(var.acm_domain_name, "*.")
  health_check_domain = "healthcheck-${var.namespace}-${var.environment}.${local.route_53_zone}"
}


data "aws_route53_zone" "default" {
  name = local.route_53_zone
}

################################################################################
## ecs
################################################################################
module "ecs" {
  source  = "sourcefuse/arc-ecs/aws"
  version = "1.4.4"

  environment = var.environment
  namespace   = var.namespace

  vpc_id                  = data.aws_vpc.vpc.id
  alb_subnet_ids          = data.aws_subnets.public.ids
  health_check_subnet_ids = data.aws_subnets.private.ids

  # Devs: DO NOT override, otherwise tests will fail #
  access_logs_enabled                             = false
  alb_access_logs_s3_bucket_force_destroy         = true
  alb_access_logs_s3_bucket_force_destroy_enabled = true
  # -------------------------- END ------------------------- #

  # create acm certificate and dns record for health check #
  # route_53_zone                 = local.route_53_zone
  route_53_zone_name            = data.aws_route53_zone.default.name
  create_acm_certificate        = true
  route_53_zone_id              = data.aws_route53_zone.default.zone_id
  acm_domain_name               = var.acm_domain_name
  acm_subject_alternative_names = []
  health_check_route_53_records = [
    local.health_check_domain
  ]

  service_discovery_private_dns_namespace = [
    "${var.namespace}.${var.environment}.${local.route_53_zone}"
  ]

  tags = module.terraform-aws-arc-tags.tags
}

module "backstage" {
  source                 = "sourcefuse/arc-backstage-ecs/aws"
  version                = "0.2.6"
  alb_dns_name           = module.ecs.alb_dns_name
  alb_zone_id            = module.ecs.alb_dns_zone_id
  app_host_name          = var.app_host_name
  cluster_id             = module.ecs.cluster_id
  cluster_name           = module.ecs.cluster_name
  environment            = var.environment
  route_53_records       = [var.app_host_name]
  lb_listener_arn        = module.ecs.alb_https_listener_arn
  lb_security_group_ids  = [module.ecs.alb_security_group_id]
  route_53_zone_name     = var.route_53_zone_name
  subnet_ids             = data.aws_subnets.private.ids
  vpc_id                 = data.aws_vpc.vpc.id
  container_image        = var.container_image
  tags                   = module.tags.tags
  task_definition_cpu    = 2048
  task_definition_memory = 4096
  secret_name            = var.secret_name
}
