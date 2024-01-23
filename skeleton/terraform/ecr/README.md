# Reference Architecture DevOps Infrastructure: ECR Applications  

## Overview

ECR Repos for the SourceFuse DevOps Reference Architecture Infrastructure.  

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
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.2 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ecr"></a> [ecr](#module\_ecr) | cloudposse/ecr/aws | 0.40.0 |
| <a name="module_terraform-aws-arc-tags"></a> [terraform-aws-arc-tags](#module\_terraform-aws-arc-tags) | sourcefuse/arc-tags/aws | 1.2.5 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `"dev"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace for the resources. | `string` | `"demo"` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | Name of the AWS profile to use | `string` | `"default"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the project. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"us-east-1"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
