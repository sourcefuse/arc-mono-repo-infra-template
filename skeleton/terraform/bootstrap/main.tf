################################################################
## defaults
################################################################
terraform {
  required_version = "~> 1.3, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0, < 6.0"
    }
  }

  #  backend "s3" {}
}

module "terraform-aws-arc-tags" {
  source      = "sourcefuse/arc-tags/aws"
  version     = "1.2.7"
  environment = var.environment
  project     = var.project_name

  extra_tags = {
    MonoRepo     = "True"
    MonoRepoPath = "terraform/bootstrap"
  }
}

provider "aws" {
  region = var.region
}

################################################################
## backend state configuration
################################################################
module "bootstrap" {
  source  = "sourcefuse/arc-bootstrap/aws"
  version = "1.1.8"

  bucket_name   = var.bucket_name
  dynamodb_name = var.dynamodb_name

  tags = merge(module.terraform-aws-arc-tags.tags, tomap({
    Name         = var.bucket_name
    DynamoDBName = var.dynamodb_name
  }))
}
