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
  backend "s3" {}
}

provider "aws" {
  region = var.region
}

module "terraform-aws-arc-tags" {
  source      = "sourcefuse/arc-tags/aws"
  version     = "1.2.7"
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
  source   = "cloudposse/ecr/aws"
  version  = "0.42.1"
  for_each = local.ecr_repos

  name                 = each.value.name
  image_tag_mutability = var.image_tag_mutability
  scan_images_on_push  = var.scan_images_on_push
  tags                 = module.terraform-aws-arc-tags.tags
}
