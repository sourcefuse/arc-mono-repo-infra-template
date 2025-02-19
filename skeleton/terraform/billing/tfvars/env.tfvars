namespace   = "${{ values.namespace }}"
region      = "${{ values.region }}"
environment = "${{ values.environment }}"
project_name = "${{ values.component_id }}"

budgets = [
  {
    name            = "ecs-fargate-monthly-budget"
    budget_type     = "COST"
    limit_amount    = "300" // Adjust the limit amount as needed
    limit_unit      = "USD"
    time_period_end = "2025-06-15_00:00"
    time_unit       = "MONTHLY"

    cost_filter = {
      Service = ["Amazon Elastic Container Service"]
    }

    cost_types = {
      include_discount           = true
      include_other_subscription = true
      include_recurring          = true
      include_subscription       = true
      include_tax                = true
      include_upfront            = true
      include_support            = true
      include_refund             = false
      include_credit             = false
      use_blended                = false
    }

    notification = {
      comparison_operator        = "GREATER_THAN"
      threshold                  = "100"
      threshold_type             = "PERCENTAGE"
      notification_type          = "ACTUAL"
      subscriber_email_addresses = ["example@example-email.com"]
    }
  },
  {
    name         = "total-monthly-budget"
    budget_type  = "COST"
    limit_amount = "1000"
    limit_unit   = "USD"
    time_unit    = "MONTHLY"

    notification = {
      comparison_operator        = "GREATER_THAN"
      threshold                  = "100"
      threshold_type             = "PERCENTAGE"
      notification_type          = "ACTUAL"
      subscriber_email_addresses = ["example@example-email.com"]
    }
  }
]

encryption_enabled    = true
notifications_enabled = true
slack_webhook_url     = null
slack_channel         = null
slack_username        = null
