# Reference Architecture DevOps Infrastructure: ECR Applications  

## Overview

ECR Repos for the SourceFuse DevOps Reference Architecture Infrastructure.  

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
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.1.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ecr"></a> [ecr](#module\_ecr) | cloudposse/ecr/aws | 0.32.3 |
| <a name="module_tags"></a> [tags](#module\_tags) | git@github.com:sourcefuse/terraform-aws-refarch-tags | 1.0.1 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `"dev"` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | Name of the AWS profile to use | `string` | `"default"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"us-east-1"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
