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

module "terraform-aws-arc-tags" {
  source      = "sourcefuse/arc-tags/aws"
  version     = "1.2.5"
  environment = var.environment
  project     = var.project_name

  extra_tags = {
    MonoRepo     = "True"
    MonoRepoPath = "terraform/network"
  }
}

################################################################
## network
################################################################
module "network" {
  source  = "sourcefuse/arc-network/aws"
  version = "2.6.3"

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

  tags = module.terraform-aws-arc-tags.tags
}
