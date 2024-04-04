# Reference Architecture DevOps Infrastructure: AWS Budgets

## Overview

AWS Billing and Budgets for the SourceFuse DevOps Reference Architecture Infrastructure.

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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_budgets"></a> [budgets](#module\_budgets) | sourcefuse/arc-billing/aws | 0.0.1 |
| <a name="module_tags"></a> [tags](#module\_tags) | sourcefuse/arc-tags/aws | 1.2.3 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_alerts_sns_subscribers"></a> [billing\_alerts\_sns\_subscribers](#input\_billing\_alerts\_sns\_subscribers) | A map of subscription configurations for SNS topics<br><br>For more information, see:<br>https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription#argument-reference<br><br>protocol:<br>  The protocol to use. The possible values for this are: sqs, sms, lambda, application. (http or https are partially<br>  supported, see link) (email is an option but is unsupported in terraform, see link).<br>endpoint:<br>  The endpoint to send data to, the contents will vary with the protocol. (see link for more information)<br>endpoint\_auto\_confirms:<br>  Boolean indicating whether the end point is capable of auto confirming subscription e.g., PagerDuty. Default is<br>  false<br>raw\_message\_delivery:<br>  Boolean indicating whether or not to enable raw message delivery (the original message is directly passed, not wrapped in JSON with the original message in the message property).<br>  Default is false | <pre>map(object({<br>    protocol               = string<br>    endpoint               = string<br>    endpoint_auto_confirms = bool<br>    raw_message_delivery   = bool<br>  }))</pre> | `null` | no |
| <a name="input_budgets"></a> [budgets](#input\_budgets) | A list of Budgets to create. | `any` | `[]` | no |
| <a name="input_encryption_enabled"></a> [encryption\_enabled](#input\_encryption\_enabled) | Whether or not to use encryption. If set to `true` and no custom value for KMS key (kms\_master\_key\_id) is provided, a KMS key is created. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | environment value, e.g 'prod', 'staging', 'dev', 'UAT' | `string` | `"poc"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace for the resources. | `string` | n/a | yes |
| <a name="input_notifications_enabled"></a> [notifications\_enabled](#input\_notifications\_enabled) | Whether or not to setup Slack notifications. Set to `true` to create an SNS topic and Lambda function to send alerts to Slack. | `bool` | `false` | no |
| <a name="input_project"></a> [project](#input\_project) | The project name | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"us-east-1"` | no |
| <a name="input_slack_channel"></a> [slack\_channel](#input\_slack\_channel) | The name of the channel in Slack for notifications. Only used when `notifications_enabled` is `true` | `string` | `""` | no |
| <a name="input_slack_username"></a> [slack\_username](#input\_slack\_username) | The username that will appear on Slack messages. Only used when `notifications_enabled` is `true` | `string` | `""` | no |
| <a name="input_slack_webhook_url"></a> [slack\_webhook\_url](#input\_slack\_webhook\_url) | The URL of Slack webhook. Only used when `notifications_enabled` is `true` | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_budgets"></a> [budgets](#output\_budgets) | List of Budgets that are being managed by this module |
| <a name="output_lambda_cloudwatch_log_group_arn"></a> [lambda\_cloudwatch\_log\_group\_arn](#output\_lambda\_cloudwatch\_log\_group\_arn) | The ARN of the Log Group used by the Slack Notify Lambda |
| <a name="output_lambda_function_arn"></a> [lambda\_function\_arn](#output\_lambda\_function\_arn) | The ARN of the Lambda function |
| <a name="output_lambda_function_invoke_arn"></a> [lambda\_function\_invoke\_arn](#output\_lambda\_function\_invoke\_arn) | The ARN to be used for invoking lambda function from API Gateway |
| <a name="output_lambda_function_name"></a> [lambda\_function\_name](#output\_lambda\_function\_name) | The name of the Lambda function |
| <a name="output_lambda_iam_role_arn"></a> [lambda\_iam\_role\_arn](#output\_lambda\_iam\_role\_arn) | The ARN of the IAM role used by Lambda function |
| <a name="output_sns_topic_arn"></a> [sns\_topic\_arn](#output\_sns\_topic\_arn) | ARN of the SNS topic created for alerts |
| <a name="output_sns_topic_name"></a> [sns\_topic\_name](#output\_sns\_topic\_name) | The name of the SNS topic created for notifications |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
