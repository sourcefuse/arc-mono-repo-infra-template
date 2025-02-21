################################################################################
## defaults
################################################################################
terraform {
  required_version = "~> 1.3, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0, < 6.0"
    }
  }

  backend "s3" {}
}

provider "aws" {
  region = var.region
}


module "terraform-aws-arc-tags" {
  source      = "sourcefuse/arc-tags/aws"
  version     = "1.2.7"
  environment = var.environment
  project     = var.project_name

  extra_tags = {
    MonoRepo     = "True"
    MonoRepoPath = "terraform/db"
  }
}


{% if values.rds %}

################################################################################
## db postgres
################################################################################


module "rds" {
  source  = "sourcefuse/arc-db/aws"
  version = "4.0.0"

  environment = var.environment
  namespace   = var.namespace
  vpc_id      = data.aws_vpc.vpc.id

  name                 = local.rds_name
  engine_type          = local.rds_engine_type
  db_server_class      = local.rds_db_server_class
  port                 = local.rds_port
  username             = local.rds_username
  manage_user_password = local.rds_manage_user_password
  engine               = local.rds_engine
  engine_version       = local.rds_engine_version

  license_model         = local.rds_license_model
  db_subnet_group_data  = local.db_subnet_group_data
  security_group_data   = local.rds_security_group_data
  performance_insights_enabled = true
  monitoring_interval   = 5

  kms_data = local.kms_data

  tags = module.terraform-aws-arc-tags.tags
}

{% endif %}

{% if values.aurora %}
################################################################################
## db aurora-postgresql
################################################################################

module "rds" {
  source  = "sourcefuse/arc-db/aws"
  version = "4.0.0"

  environment = var.environment
  namespace   = var.namespace
  vpc_id      = data.aws_vpc.vpc.id

  name           = local.aurora_name
  engine_type    = local.aurora_engine_type
  port           = local.aurora_port
  username       = local.aurora_username
  engine         = local.aurora_engine
  engine_version = local.aurora_engine_version

  license_model          = local.aurora_license_model
  rds_cluster_instances  = local.aurora_rds_cluster_instances
  db_subnet_group_data   = local.aurora_db_subnet_group_data
  performance_insights_enabled = true

  kms_data = local.aurora_kms_data

  tags = module.terraform-aws-arc-tags.tags
}

{% endif %}