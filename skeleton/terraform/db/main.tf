################################################################################
## defaults
################################################################################
terraform {
  required_version = "~> 1.3"

  required_providers {
    aws = {
      version = "~> 4.0"
      source  = "hashicorp/aws"
    }
  }

  backend "s3" {}
}

module "tags" {
  source = "git::https://github.com/sourcefuse/terraform-aws-refarch-tags?ref=1.2.1"

  environment = var.environment
  project     = var.project_name

  extra_tags = {
    MonoRepo     = "True"
    MonoRepoPath = "terraform/resources/db"
  }
}

provider "aws" {
  region = var.region
}

################################################################################
## db
################################################################################
module "aurora" {
  source = "git::https://github.com/sourcefuse/terraform-aws-ref-arch-db?ref=1.6.6"

  environment = var.environment
  namespace   = var.namespace
  region      = var.region
  vpc_id      = data.aws_vpc.vpc.id

  aurora_cluster_enabled             = true
  aurora_cluster_name                = var.name
  enhanced_monitoring_name           = "${var.namespace}-${var.environment}-enhanced-monitoring"
  aurora_db_admin_username           = var.db_admin_username
  aurora_db_name                     = var.name
  aurora_allow_major_version_upgrade = false
  aurora_auto_minor_version_upgrade  = true
  aurora_cluster_size                = var.cluster_size
  aurora_instance_type               = "db.serverless"
  aurora_subnets                     = data.aws_subnets.private.ids
  aurora_security_groups             = var.aurora_security_groups
  aurora_allowed_cidr_blocks         = [data.aws_vpc.vpc.cidr_block]

  aurora_serverlessv2_scaling_configuration = {
    max_capacity = 16
    min_capacity = 2
  }
}
