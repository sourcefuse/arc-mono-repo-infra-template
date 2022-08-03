# Reference Architecture DevOps Infrastructure: Bootstrap  

## Overview

AWS bootstrap for the SourceFuse DevOps Reference Architecture Infrastructure. This will contain resources used for Terraform state.  

## First Time Usage

Initialize Terraform
```shell
terraform init -backend-config=config.dev.hcl
```

Create a `dev` workspace
```shell
terraform workspace new dev
```

Apply Terraform
```shell
terraform apply -backend-config=config.dev.hcl
``` 

Uncomment the contents of `backend "s3"`. Initialize Terraform again and migrate the state.
```shell
terraform init -backend-config=config.dev.hcl
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.1.3 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bootstrap"></a> [bootstrap](#module\_bootstrap) | git::git@github.com:sourcefuse/terraform-module-aws-bootstrap | 1.0.1 |
| <a name="module_tags"></a> [tags](#module\_tags) | git@github.com:sourcefuse/terraform-aws-refarch-tags | 1.0.1 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Name of the bucket. | `string` | `"sf-refarch-devops-infra-state"` | no |
| <a name="input_dynamodb_name"></a> [dynamodb\_name](#input\_dynamodb\_name) | Name of the Dynamo DB lock table. | `string` | `"sf_refarch_devops_infra_state"` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | Profile for the AWS backend state provider. | `string` | `"poc2"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | `"us-east-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_state_bucket_arn"></a> [state\_bucket\_arn](#output\_state\_bucket\_arn) | State bucket ARN |
| <a name="output_state_bucket_name"></a> [state\_bucket\_name](#output\_state\_bucket\_name) | State bucket name |
| <a name="output_state_lock_table_arn"></a> [state\_lock\_table\_arn](#output\_state\_lock\_table\_arn) | State lock table ARN |
| <a name="output_state_lock_table_name"></a> [state\_lock\_table\_name](#output\_state\_lock\_table\_name) | State lock table name |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
