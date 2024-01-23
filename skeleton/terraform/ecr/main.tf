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

module "terraform-aws-arc-tags" {
  source      = "sourcefuse/arc-tags/aws"
  version     = "1.2.5"
  environment = var.environment
  project     = var.project_name

  extra_tags = {
    MonoRepo     = "True"
    MonoRepoPath = "terraform/ecr"
  }
}

################################################################################
## ecr
################################################################################
module "ecr" {
  source  = "cloudposse/ecr/aws"
  version = "0.40.0"

  namespace = var.namespace
  stage     = var.environment
  for_each  = local.ecr_repos
  name      = each.value.name
  tags      = module.tags.tags
}
