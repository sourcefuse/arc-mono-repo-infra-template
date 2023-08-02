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

    awsutils = {
      source  = "cloudposse/awsutils"
      version = "~> 0.15"
    }
  }

  backend "s3" {}
}

provider "aws" {
  region = var.region
}

provider "awsutils" {
  region = var.region
}

module "tags" {
  source = "git::https://github.com/sourcefuse/terraform-aws-refarch-tags?ref=1.2.1"

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
  source = "git::https://github.com/sourcefuse/terraform-aws-ref-arch-network?ref=2.3.0"

  namespace          = var.namespace
  availability_zones = var.availability_zones
  environment        = var.environment

  vpc_ipv4_primary_cidr_block    = var.vpc_cidr_block
  vpc_endpoints_enabled          = false
  vpn_gateway_enabled            = false
  direct_connect_enabled         = false
  interface_vpc_endpoints        = {}
  gateway_vpc_endpoints          = {}
  client_vpn_authorization_rules = []

  tags = module.tags.tags
}
