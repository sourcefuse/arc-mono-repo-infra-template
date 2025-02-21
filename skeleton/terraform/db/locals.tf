{% if values.rds %}
locals {
  rds_name                = "${var.namespace}-${var.environment}-test"
  rds_engine_type         = "rds"
  rds_db_server_class     = "db.t3.small"
  rds_port               = 5432
  rds_username           = "postgres"
  rds_manage_user_password = true
  rds_engine             = "postgres"
  rds_engine_version     = "16.3"
  rds_license_model      = "postgresql-license"

  db_subnet_group_data = {
    name        = "${var.namespace}-${var.environment}-subnet-group"
    create      = true
    description = "Subnet group for rds instance"
    subnet_ids  = data.aws_subnets.private.ids
  }

  kms_data = {
    create                  = true
    description             = "KMS for Performance insight and storage"
    deletion_window_in_days = 7
    enable_key_rotation     = true
  }
  rds_security_group_data = {
    create      = true
    description = "Security Group for RDS instance"

    ingress_rules = [
      {
        description = "Allow traffic from local network"
        cidr_block  = data.aws_vpc.vpc.cidr_block
        from_port   = 5432
        ip_protocol = "tcp"
        to_port     = 5432
      }
    ]

    egress_rules = [
      {
        description = "Allow all outbound traffic"
        cidr_block  = "0.0.0.0/0"
        from_port   = -1
        ip_protocol = "-1"
        to_port     = -1
      }
    ]
  }
}
{% endif %}


{% if values.aurora %}
locals {
  aurora_name           = "${var.namespace}-${var.environment}-test"
  aurora_engine_type    = "cluster"
  aurora_port           = 5432
  aurora_username       = "postgres"
  aurora_engine         = "aurora-postgresql"
  aurora_engine_version = "16.2"
  aurora_license_model  = "postgresql-license"

  aurora_rds_cluster_instances = [
    {
      instance_class          = "db.t3.medium"
      db_parameter_group_name = "default.aurora-postgresql16"
      apply_immediately       = true
      promotion_tier          = 1
    }
  ]

  aurora_db_subnet_group_data = {
    name        = "${var.namespace}-${var.environment}-subnet-group"
    create      = true
    description = "Subnet group for rds instance"
    subnet_ids  = data.aws_subnets.private.ids
  }

  aurora_kms_data = {
    create                  = true
    description             = "KMS for Performance insight and storage"
    deletion_window_in_days = 7
    enable_key_rotation     = true
  }
}
{% endif %}
