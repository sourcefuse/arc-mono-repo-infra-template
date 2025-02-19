################################################################################
## defaults
################################################################################
terraform {
  required_version = "~> 1.3, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0, < 6.0"
    }
  }
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
    RepoName = "terraform-aws-arc-s3"
  }
}

module "s3" {
  source  = "sourcefuse/arc-s3/aws"
  version = "0.0.4"

  for_each = local.buckets

  name              = each.value.name
  acl               = each.value.acl
  enable_versioning = each.value.enable_versioning
  tags              = module.tags.tags
}
