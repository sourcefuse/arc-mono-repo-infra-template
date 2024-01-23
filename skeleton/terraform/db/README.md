# Reference Architecture DevOps Infrastructure: [Database](https://sourcefuse.github.io/arc-docs/arc-iac-docs/modules/terraform-aws-ref-arch-db/) 

## Overview

AWS RDS/Aurora for the SourceFuse DevOps Reference Architecture Infrastructure.  

## Usage
1. Initialize the backend:
  ```shell
  terraform init -backend-config config.dev.hcl
  ```
2. Create a `dev` workspace
  ```shell
  terraform workspace new dev
  ```
3. Plan Terraform
  ```shell
  terraform plan -var-file dev.tfvars
  ```
4. Apply Terraform
  ```shell
  terraform apply -var-file dev.tfvars
  ```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.67.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aurora"></a> [aurora](#module\_aurora) | sourcefuse/arc-db/aws | 2.0.6 |
| <a name="module_terraform-aws-arc-tags"></a> [terraform-aws-arc-tags](#module\_terraform-aws-arc-tags) | sourcefuse/arc-tags/aws | 1.2.5 |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_subnets.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_major_version_upgrade"></a> [allow\_major\_version\_upgrade](#input\_allow\_major\_version\_upgrade) | Enable to allow major engine version upgrades when changing engine versions. Defaults to false. | `bool` | `false` | no |
| <a name="input_aurora_security_groups"></a> [aurora\_security\_groups](#input\_aurora\_security\_groups) | List of security group IDs to be allowed to connect to the DB instance | `list(string)` | `[]` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window | `bool` | `true` | no |
| <a name="input_cluster_family"></a> [cluster\_family](#input\_cluster\_family) | The family of the DB cluster parameter group | `string` | `"aurora-postgresql10"` | no |
| <a name="input_cluster_size"></a> [cluster\_size](#input\_cluster\_size) | Number of DB instances to create in the cluster | `number` | `0` | no |
| <a name="input_db_admin_username"></a> [db\_admin\_username](#input\_db\_admin\_username) | Name of the default DB admin user role | `string` | `"db_admin"` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | The name of the database engine to be used for this DB cluster. Valid values: `aurora`, `aurora-mysql`, `aurora-postgresql` | `string` | `"aurora-postgresql"` | no |
| <a name="input_engine_mode"></a> [engine\_mode](#input\_engine\_mode) | The database engine mode. Valid values: `parallelquery`, `provisioned`, `serverless` | `string` | `"serverless"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The version of the database engine to use. See `aws rds describe-db-engine-versions` | `string` | `"aurora-postgresql13.3"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `"dev"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type to use | `string` | `"db.t3.medium"` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `"arc"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace for the resources. | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name | `string` | `"sourcefuse"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"us-east-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aurora_arn"></a> [aurora\_arn](#output\_aurora\_arn) | Amazon Resource Name (ARN) of cluster |
| <a name="output_aurora_endpoint"></a> [aurora\_endpoint](#output\_aurora\_endpoint) | The DNS address of the Aurora instance |
| <a name="output_db_admin_username"></a> [db\_admin\_username](#output\_db\_admin\_username) | DB Admin username to the SQL Server |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
