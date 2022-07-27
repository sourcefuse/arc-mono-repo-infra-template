# Reference Architecture DevOps Infrastructure: EKS Core Applications  

## Overview

AWS EKS for the SourceFuse DevOps Reference Architecture Infrastructure. 

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.1.3 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.7.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_backstage"></a> [backstage](#module\_backstage) | ./backstage | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.app_domain_records](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_ecr_repository.backstage_image_repo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecr_repository) | data source |
| [aws_eks_cluster.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |
| [aws_lb.eks_nlb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lb) | data source |
| [aws_route53_zone.default_domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_ssm_parameter.db_cluster_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.db_cluster_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.db_cluster_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.github_client_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.github_client_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.github_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_domains"></a> [app\_domains](#input\_app\_domains) | Domains used to create A records for the applications | `list(string)` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the EKS cluster | `string` | n/a | yes |
| <a name="input_db_cluster_endpoint"></a> [db\_cluster\_endpoint](#input\_db\_cluster\_endpoint) | SSM param name for the DB cluster | `string` | n/a | yes |
| <a name="input_db_cluster_password"></a> [db\_cluster\_password](#input\_db\_cluster\_password) | SSM param name for the DB cluster service account password | `string` | n/a | yes |
| <a name="input_db_cluster_user"></a> [db\_cluster\_user](#input\_db\_cluster\_user) | SSM param name for the DB cluster service account user | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `"dev"` | no |
| <a name="input_github_client_id"></a> [github\_client\_id](#input\_github\_client\_id) | SSM param name for the  GitHub OAuth 2.0 app client\_id | `string` | n/a | yes |
| <a name="input_github_client_secret"></a> [github\_client\_secret](#input\_github\_client\_secret) | SSM param name for the GitHub OAuth 2.0 app client\_id | `string` | n/a | yes |
| <a name="input_github_token"></a> [github\_token](#input\_github\_token) | SSM param name for the GitHub service account token used for GH integrations. | `string` | n/a | yes |
| <a name="input_image_repo_name"></a> [image\_repo\_name](#input\_image\_repo\_name) | name of the ecr repo. this is used to filter the repo url. this repo must exist | `string` | n/a | yes |
| <a name="input_image_tag"></a> [image\_tag](#input\_image\_tag) | image tag to be deployed. this tag much exist in the image repo. | `string` | `"0.1.3"` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | Name of the AWS profile to use | `string` | `"default"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"us-east-1"` | no |
| <a name="input_route_53_zone"></a> [route\_53\_zone](#input\_route\_53\_zone) | Route 53 domain to create A records for individual applications running in EKS. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_oidc_issuer"></a> [oidc\_issuer](#output\_oidc\_issuer) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
