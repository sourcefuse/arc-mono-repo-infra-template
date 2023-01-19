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
  source = "git::https://github.com/sourcefuse/terraform-aws-refarch-tags?ref=1.1.0"

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
  source = "git::https://github.com/sourcefuse/terraform-aws-ref-arch-db?ref=1.6.1"
  count  = var.db_type == "aurora" ? 1 : 0

  environment = var.environment
  namespace   = var.namespace
  region      = var.region
  vpc_id      = data.aws_vpc.vpc.id

  aurora_cluster_enabled             = true
  aurora_cluster_name                = "${var.name}-${var.namespace}-${var.environment}"
  enhanced_monitoring_name           = "${var.name}-${var.namespace}-${var.environment}-enhanced-monitoring"
  aurora_db_admin_username           = var.db_admin_username
  aurora_db_name                     = var.name
  aurora_allow_major_version_upgrade = false
  aurora_auto_minor_version_upgrade  = true
  aurora_cluster_size                = 0
  aurora_instance_type               = "db.serverless"
  aurora_subnets                     = data.aws_subnets.private.ids
  aurora_security_groups             = data.aws_security_groups.db_sg.ids
  aurora_allowed_cidr_blocks         = [data.aws_vpc.vpc.cidr_block]

  aurora_serverlessv2_scaling_configuration = {
    max_capacity = 16
    min_capacity = 2
  }
}

module "rds_sql_server" {
  source = "git::https://github.com/sourcefuse/terraform-aws-ref-arch-db?ref=1.6.1"
  count  = var.db_type == "sqlserver-ex" ? 1 : 0

  environment = var.environment
  namespace   = var.namespace
  region      = var.region
  vpc_id      = data.aws_vpc.vpc.id

  account_id                               = data.aws_caller_identity.this.id
  rds_instance_enabled                     = true
  rds_instance_name                        = "${var.name}-${var.namespace}-${var.environment}"
  enhanced_monitoring_name                 = "${var.name}-${var.namespace}-${var.environment}-enhanced-monitoring"
  rds_instance_dns_zone_id                 = ""
  rds_instance_host_name                   = ""
  rds_instance_database_name               = null // sql server database name must be null
  rds_instance_database_user               = var.db_admin_username
  rds_instance_database_port               = 1433
  rds_instance_engine                      = "sqlserver-ex" // express edition.
  rds_instance_engine_version              = "15.00.4236.7.v1"
  rds_instance_major_engine_version        = "15.00"
  rds_instance_db_parameter_group          = "default.sqlserver-ex-15.0"
  rds_instance_db_parameter                = []
  rds_instance_db_options                  = []
  enable_custom_option_group               = true
  rds_instance_ca_cert_identifier          = "rds-ca-2019"
  rds_instance_publicly_accessible         = false
  rds_instance_multi_az                    = false
  rds_instance_storage_type                = "gp2"
  rds_instance_instance_class              = "db.t3.small"
  rds_instance_allocated_storage           = 25
  rds_instance_storage_encrypted           = false // sql server express doesn't support encryption at rest
  rds_instance_snapshot_identifier         = null
  rds_instance_auto_minor_version_upgrade  = true
  rds_instance_allow_major_version_upgrade = true
  rds_instance_apply_immediately           = true
  rds_instance_maintenance_window          = "Mon:00:00-Mon:02:00"
  rds_instance_skip_final_snapshot         = true
  rds_instance_copy_tags_to_snapshot       = true
  rds_instance_backup_retention_period     = 3
  rds_instance_backup_window               = "22:00-23:59"
  rds_instance_security_group_ids          = data.aws_security_groups.db_sg.ids
  rds_instance_allowed_cidr_blocks         = [data.aws_vpc.vpc.cidr_block]
  rds_instance_subnet_ids                  = data.aws_subnets.private.ids
}
