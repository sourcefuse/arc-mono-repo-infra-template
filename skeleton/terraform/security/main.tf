################################################################################
## defaults
################################################################################
terraform {
  required_version = "~> 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
  backend "s3" {}
}

provider "aws" {
  region = var.region
}

module "tags" {
  source  = "sourcefuse/arc-tags/aws"
  version = "1.2.7"

  environment = var.environment
  project     = var.project

  extra_tags = {
    Repo         = "github.com/sourcefuse/terraform-aws-arc-security"
    MonoRepo     = "True"
    MonoRepoPath = "terraform/security"
  }
}


module "cloud_security" {
  source  = "sourcefuse/arc-security/aws"
  version = "1.1.0"

  region      = var.region
  environment = var.environment
  namespace   = var.namespace

  enable_inspector    = true
  enable_aws_config   = true
  enable_guard_duty   = true
  enable_security_hub = true

  create_config_iam_role = true

  aws_config_sns_subscribers   = local.aws_config_sns_subscribers
  guard_duty_sns_subscribers   = local.guard_duty_sns_subscribers
  security_hub_sns_subscribers = local.security_hub_sns_subscribers

  aws_config_managed_rules       = var.aws_config_managed_rules
  enabled_security_hub_standards = local.security_hub_standards

  inspector_schedule_expression = var.inspector_schedule_expression
  inspector_account_list        = ["123456789012"]

  tags = module.tags.tags
}
