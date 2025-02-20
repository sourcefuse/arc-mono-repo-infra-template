data "aws_ssm_parameter" "billing" {
  name = "/${var.namespace}/${var.environment}/security-hub/opsgenie/api-key"
}