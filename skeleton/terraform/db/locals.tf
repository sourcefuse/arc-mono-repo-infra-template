locals {

  engine = "${{ values.databaseEngine }}"
  engine_type         = "${{ values.databaseEngineType }}"

  license_model_map = {
    aurora-mysql      = null
    aurora-postgresql = null
    mariadb           = "general-public-license"
    mysql             = "general-public-license"
    oracle-ee         = "bring-your-own-license"
    oracle-se2        = "bring-your-own-license"
    postgres          = "postgresql-license"
    sqlserver-ee      = "license-included"
    sqlserver-se      = "license-included"
    sqlserver-ex      = "license-included"
    sqlserver-web     = "license-included"
  }

  // TODO: validate the version and parameter_group_family
database_engines_defaults = {
    aurora-mysql = {
      port                   = 3306
      user                   = "admin"
      latest_version         = "5.7.mysql_aurora.2.10.2"
      parameter_group_family = "aurora-mysql5.7"
    }
    aurora-postgresql = {
      port                   = 5432
      user                   = "postgres"
      latest_version         = "13.7"
      parameter_group_family = "aurora-postgresql13"
    }
    mariadb = {
      port                   = 3306
      user                   = "admin"
      latest_version         = "10.6.12"
      parameter_group_family = "mariadb10.6"
    }
    mysql = {
      port                   = 3306
      user                   = "admin"
      latest_version         = "8.0.28"
      parameter_group_family = "mysql8.0"
    }
    oracle-ee = {
      port                   = 1521
      user                   = "admin"
      latest_version         = "19.0.0.0.ru-2022-01.rur-2022-01.r1"
      parameter_group_family = "oracle-ee-19"
    }
    oracle-se2 = {
      port                   = 1521
      user                   = "admin"
      latest_version         = "19.0.0.0.ru-2022-01.rur-2022-01.r1"
      parameter_group_family = "oracle-se2-19"
    }
    postgres = {
      port                   = 5432
      user                   = "postgres"
      latest_version         = "14.3"
      parameter_group_family = "postgres14"
    }
    sqlserver-ee = {
      port                   = 1433
      user                   = "admin"
      latest_version         = "15.00.4236.7.v1"
      parameter_group_family = "sqlserver-ee-15.0"
    }
    sqlserver-se = {
      port                   = 1433
      user                   = "admin"
      latest_version         = "15.00.4236.7.v1"
      parameter_group_family = "sqlserver-se-15.0"
    }
    sqlserver-ex = {
      port                   = 1433
      user                   = "admin"
      latest_version         = "15.00.4236.7.v1"
      parameter_group_family = "sqlserver-ex-15.0"
    }
    sqlserver-web = {
      port                   = 1433
      user                   = "admin"
      latest_version         = "15.00.4236.7.v1"
      parameter_group_family = "sqlserver-web-15.0"
    }
  }


  license_model = local.license_model_map[local.engine]
  port = local.engines_defaults[local.engine].port
  username = local.engines_defaults[local.engine].user
  version = local.engines_defaults[local.engine].latest_version
  parameter_group_family = local.engines_defaults[local.engine].parameter_group_family

}

{% if values.databaseEngineType == "rds" %}
locals {
  rds_name                = "${var.namespace}-${var.environment}-test"
  rds_engine_type         = local.engine_type
  rds_db_server_class     = "db.t3.small"
  rds_port               = local.port
  rds_username           = local.username
  rds_manage_user_password = true
  rds_engine             = local.engine
  rds_engine_version     = local.version
  rds_license_model      = local.license_model

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


{% if values.databaseEngineType == "cluster" %}
locals {
  aurora_name           = "${var.namespace}-${var.environment}-test"
  aurora_engine_type    = local.engine_type
  aurora_port           = local.port
  aurora_username       = local.username
  aurora_engine         = local.engine
  aurora_engine_version = local.version
  aurora_license_model  = local.license_model

  aurora_rds_cluster_instances = [
    {
      instance_class          = "db.t3.medium"
      db_parameter_group_name = local.parameter_group_family
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
