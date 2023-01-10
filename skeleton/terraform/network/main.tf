################################################################
## defaults
################################################################
terraform {
  required_version = "~> 1.0"

  required_providers {
    aws = {
      version = "~> 4.0"
      source  = "hashicorp/aws"
    }
  }

  backend "s3" {}
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
    MonoRepoPath = "terraform/resources/network"
  }
}

################################################################
## network
################################################################
module "network" {
  source = "git::https://github.com/sourcefuse/terraform-aws-ref-arch-network?ref=1.2.3"

  namespace          = var.namespace
  availability_zones = var.availability_zones
  vpc_cidr_block     = var.vpc_cidr_block
  environment        = var.environment

  tags = module.tags.tags
}
