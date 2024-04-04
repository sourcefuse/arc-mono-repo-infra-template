module "tags" {
  source  = "sourcefuse/arc-tags/aws"
  version = "1.2.3"

  environment = var.environment
  project     = var.project

  extra_tags = {
    Repo         = "github.com/sourcefuse/terraform-aws-arc-billing"
    MonoRepo     = "True"
    MonoRepoPath = "terraform/billing"
  }
}

module "budgets" {
  source  = "sourcefuse/arc-billing/aws"
  version = "0.0.1"

  namespace   = var.namespace
  environment = var.environment

  budgets = var.budgets

  notifications_enabled = var.notifications_enabled
  encryption_enabled    = var.encryption_enabled

  slack_webhook_url = var.slack_webhook_url
  slack_channel     = var.slack_channel
  slack_username    = var.slack_username

  billing_alerts_sns_subscribers = var.billing_alerts_sns_subscribers

  tags = module.tags.tags
}