# Reference Architecture DevOps Infrastructure: Database  

## Overview

AWS RDS/Aurora for the SourceFuse DevOps Reference Architecture Infrastructure.   

## First Time Usage
```shell
terraform init -backend-config=config.dev.hcl
```

Create a `dev` workspace
```shell
terraform workspace new dev
```

Apply Terraform
```shell
terraform apply
```

## Production Setup
```shell
terraform init -backend-config=config.prod.hcl
```

Create a `prod` workspace
```shell
terraform workspace new prod
```

Apply Terraform
```shell
terraform apply -var-file=prod.tfvars
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.1.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ref_arch_db"></a> [ref\_arch\_db](#module\_ref\_arch\_db) | git@github.com:sourcefuse/terraform-aws-ref-arch-db | 1.1.0 |
| <a name="module_tags"></a> [tags](#module\_tags) | git@github.com:sourcefuse/terraform-aws-refarch-tags | 1.0.1 |

## Resources

| Name | Type |
|------|------|
| [aws_security_groups.db_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_groups) | data source |
| [aws_subnet_ids.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_major_version_upgrade"></a> [allow\_major\_version\_upgrade](#input\_allow\_major\_version\_upgrade) | Enable to allow major engine version upgrades when changing engine versions. Defaults to false. | `bool` | `false` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window | `bool` | `true` | no |
| <a name="input_cluster_family"></a> [cluster\_family](#input\_cluster\_family) | The family of the DB cluster parameter group | `string` | `"aurora-postgresql10"` | no |
| <a name="input_cluster_size"></a> [cluster\_size](#input\_cluster\_size) | Number of DB instances to create in the cluster | `number` | `0` | no |
| <a name="input_db_admin_username"></a> [db\_admin\_username](#input\_db\_admin\_username) | Name of the default DB admin user role | `string` | `"db_admin"` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | The name of the database engine to be used for this DB cluster. Valid values: `aurora`, `aurora-mysql`, `aurora-postgresql` | `string` | `"aurora-postgresql"` | no |
| <a name="input_engine_mode"></a> [engine\_mode](#input\_engine\_mode) | The database engine mode. Valid values: `parallelquery`, `provisioned`, `serverless` | `string` | `"serverless"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The version of the database engine to use. See `aws rds describe-db-engine-versions` | `string` | `"aurora-postgresql13.3"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `"dev"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type to use | `string` | `"db.t3.medium"` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `"devops-tools"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace for the resources. | `string` | `"refarchdevops"` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | Name of the AWS profile to use | `string` | `"default"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"us-east-1"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
