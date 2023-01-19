################################################################################
## defaults
################################################################################
terraform {
  required_version = "~> 1.3"

  required_providers {
    aws = {
      version = "~> 4.0"
      source  = "hashicorp/aws"
    }

    null = {
      version = "~> 3.2"
      source  = "hashicorp/null"
    }
  }
}

provider "aws" {
  region = var.region
}

module "tags" {
  source = "git::https://github.com/sourcefuse/terraform-aws-refarch-tags?ref=1.1.0"

  environment = var.environment
  project     = var.project_name

  extra_tags = {
    MonoRepo     = "True"
    MonoRepoPath = "terraform/resources/ecr"
  }
}

################################################################################
## ecr
################################################################################
module "ecr" {
  source   = "git::https://github.com/cloudposse/terraform-aws-ecr?ref=0.35.0"
  for_each = local.ecr_repos

  name      = each.value.name
  namespace = var.namespace
  stage     = var.environment

  tags = module.tags.tags
}
