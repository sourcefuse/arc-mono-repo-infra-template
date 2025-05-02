################################################################################
## defaults
################################################################################
terraform {
  required_version = "~> 1.3, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {}
}

provider "aws" {
  region = var.region
}

module "tags" {
  source      = "sourcefuse/arc-tags/aws"
  version     = "1.2.7"
  environment = var.environment
  project     = var.project_name

  extra_tags = {
    MonoRepo     = "True"
    MonoRepoPath = "terraform/waf"
  }
}

################################################################################
## waf
################################################################################
module "waf" {
  source  = "sourcefuse/arc-waf/aws"
  version = "1.0.5"

  ## web acl
  create_web_acl         = true
  web_acl_name           = "${var.namespace}-${var.environment}-waf-web-acl"
  web_acl_description    = "Terraform managed Web ACL Configuration"
  web_acl_scope          = "REGIONAL"
  web_acl_default_action = "block"
  web_acl_visibility_config = {
    metric_name = "${var.namespace}-${var.environment}-waf-web-acl"
  }
  web_acl_rules = local.web_acl_rules

  ## ip set
  ip_set = [
    {
      name               = "example-ip-set"
      description        = "Example description"
      scope              = "REGIONAL"
      ip_address_version = "IPV4"
      addresses          = []
    }
  ]

  tags = module.tags.tags
}
