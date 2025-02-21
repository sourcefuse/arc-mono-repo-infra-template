module "tags" {
  source  = "sourcefuse/arc-tags/aws"
  version = "1.2.7"

  environment = var.environment
  project     = var.project_name

  extra_tags = {
    Repo         = "github.com/sourcefuse/terraform-aws-arc-billing"
    MonoRepo     = "True"
    MonoRepoPath = "terraform/billing"
  }
}

module "budgets" {
  source  = "sourcefuse/arc-billing/aws"
  version = "1.0.10"

  namespace   = var.namespace
  environment = var.environment

  budgets = var.budgets

  encryption_enabled          = var.encryption_enabled
  slack_notifications_enabled = var.notifications_enabled
  slack_webhook_url           = var.slack_webhook_url
  slack_channel               = var.slack_channel
  slack_username              = var.slack_username
  sns_topic_arn               = aws_sns_topic.this.arn

  billing_alerts_sns_subscribers = local.billing_alerts_sns_subscribers

  tags = module.tags.tags
}



resource "aws_sns_topic" "this" {
  name              = "${var.namespace}-${var.environment}-billing-topic"
  kms_master_key_id = "alias/aws/sns"
}

data "aws_iam_policy_document" "this" {
  statement {
    sid       = "0"
    effect    = "Allow"
    actions   = ["sns:Publish"]
    resources = [aws_sns_topic.this.arn]

    principals {
      type        = "Service"
      identifiers = ["budgets.amazonaws.com"]
    }
  }
}

resource "aws_sns_topic_policy" "this" {
  arn    = aws_sns_topic.this.arn
  policy = data.aws_iam_policy_document.this.json
}
