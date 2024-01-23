# Reference Architecture DevOps Infrastructure: [Bootstrap](https://sourcefuse.github.io/arc-docs/arc-iac-docs/modules/terraform-module-aws-bootstrap/) 

## Overview

AWS bootstrap for the SourceFuse DevOps Reference Architecture Infrastructure. This will contain resources used for managing the Terraform Backend State.  

## Usage

When this repo is created, it triggers a GitHub Action to create the initial infrastructure.  

This resource will not have the backend state saved to S3 due to it creating the required resources for the backend.  
To migrate the state into the S3 bucket, you will need to navigate to the GitHub Repo > _Actions_ > _Terraform_ then
select the tfstate artifact from the bootstrap resource.  

:exclamation: This section assumes you have already set your `AWS_PROFILE` environment variable to the proper profile to apply the state to. :exclamation:  

Once you have downloaded the tfstate file, you will move it to this directory (`terraform/bootstrap`) and do the following:  
1. Open `main.tf` and uncomment `backend "s3" {}`:
  ```
  terraform {
   required_version = "~> 1.0"

   required_providers {
     aws = {
       version = "~> 3.0"
       source  = "hashicorp/aws"
     }
   }

   backend "s3" {}
  }
  ```

2. Initialize Terraform and migrate the state to s3.
  ```shell
  terraform init -backend-config=config.dev.hcl -migrate-state
  ```

### Manually
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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bootstrap"></a> [bootstrap](#module\_bootstrap) | sourcefuse/arc-bootstrap/aws | 1.0.9 |
| <a name="module_terraform-aws-arc-tags"></a> [terraform-aws-arc-tags](#module\_terraform-aws-arc-tags) | sourcefuse/arc-tags/aws | 1.2.5 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Name of the bucket. | `string` | `"infra-state"` | no |
| <a name="input_dynamodb_name"></a> [dynamodb\_name](#input\_dynamodb\_name) | Name of the Dynamo DB lock table. | `string` | `"infra_state"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `"dev"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the project. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | `"us-east-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_state_bucket_arn"></a> [state\_bucket\_arn](#output\_state\_bucket\_arn) | State bucket ARN |
| <a name="output_state_bucket_name"></a> [state\_bucket\_name](#output\_state\_bucket\_name) | State bucket name |
| <a name="output_state_lock_table_arn"></a> [state\_lock\_table\_arn](#output\_state\_lock\_table\_arn) | State lock table ARN |
| <a name="output_state_lock_table_name"></a> [state\_lock\_table\_name](#output\_state\_lock\_table\_name) | State lock table name |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
