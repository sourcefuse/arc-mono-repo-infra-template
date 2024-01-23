## Reference Architecture DevOps Infrastructure: [Security](https://sourcefuse.github.io/arc-docs/arc-iac-docs/modules/terraform-aws-arc-security/)

## Overview

AWS Security for the SourceFuse DevOps Reference Architecture Infrastructure.

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


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5, < 2.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

No providers.

## Modules
false
## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"us-east-1"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
