data "aws_ssm_parameter" "billing" {
  name = "/${var.namespace}/${var.environment}/alerts/billing/opsgenie_key"
}