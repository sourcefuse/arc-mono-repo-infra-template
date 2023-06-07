################################################################
## defaults
################################################################
terraform {
  required_version = "~> 1.3"

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
  source = "git::https://github.com/sourcefuse/terraform-aws-refarch-tags?ref=1.2.0"

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
  source = "git::https://github.com/sourcefuse/terraform-aws-ref-arch-network?ref=2.0.5"

  namespace          = var.namespace
  availability_zones = var.availability_zones
  environment        = var.environment

  vpc_ipv4_primary_cidr_block = var.vpc_cidr_block
  vpc_endpoints_enabled       = false
  vpn_gateway_enabled         = false
  direct_connect_enabled      = false
  interface_vpc_endpoints     = {}
  gateway_vpc_endpoints       = {}

  tags = module.tags.tags
}
