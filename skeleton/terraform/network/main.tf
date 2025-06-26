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
  source      = "sourcefuse/arc-tags/aws"
  version     = "1.2.7"
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
  source      = "sourcefuse/arc-network/aws"
  version     = "3.0.6"
  namespace   = var.namespace
  environment = var.environment

  name                    = "arc-poc"
  create_internet_gateway = true
  availability_zones      = var.availability_zones
  cidr_block              = "${{ values.vpcCidrBlock }}"

  # Enable vpc_flow_logs:If `s3_bucket_arn` is null, CloudWatch logging is enabled by default. If provided, S3 logging is enabled
  vpc_flow_log_config = {
    enable            = true
    retention_in_days = 7
    s3_bucket_arn     = ""
  }

  tags = module.tags.tags
}
