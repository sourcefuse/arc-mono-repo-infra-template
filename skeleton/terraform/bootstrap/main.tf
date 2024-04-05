################################################################
## defaults
################################################################
terraform {
  required_version = "~> 1.0"

  required_providers {
    aws = {
      version = "~> 3.0"
      source  = "hashicorp/aws"
    }
  }

  #  backend "s3" {}
}

module "terraform-aws-arc-tags" {
  source      = "sourcefuse/arc-tags/aws"
  version     = "1.2.5"
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

provider "aws" {
  region = var.region
  alias  = "backend_state"
}

################################################################
## backend state configuration
################################################################
module "bootstrap" {
  source  = "sourcefuse/arc-bootstrap/aws"
  version = "1.1.3"

  providers = {
    aws = aws.backend_state
  }

  bucket_name   = var.bucket_name
  dynamodb_name = var.dynamodb_name

  tags = merge(module.terraform-aws-arc-tags.tags, tomap({
    Name         = var.bucket_name
    DynamoDBName = var.dynamodb_name
  }))
}
