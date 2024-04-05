locals {

  billing_alerts_sns_subscribers = {
    "opsgenie" = {
      protocol               = "https"
      endpoint               = data.aws_ssm_parameter.billing.value
      endpoint_auto_confirms = true
      raw_message_delivery   = false
    }
  }
}