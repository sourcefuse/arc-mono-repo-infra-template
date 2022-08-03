################################################################
## defaults
################################################################

terraform {
  required_version = "~> 1.1.3"

  backend "s3" {}
}

module "tags" {
  source = "git@github.com:sourcefuse/terraform-aws-refarch-tags?ref=1.0.1"

  environment = terraform.workspace
  project     = "refarch-devops-infra"

  extra_tags = {
    MonoRepo     = "True"
    MonoRepoPath = "terraform/resources/bootstrap"
  }
}

provider "aws" {
  region = var.region
}

provider "aws" {
  region  = var.region
  alias   = "backend_state"
  profile = var.profile
}

################################################################
## backend state configuration
################################################################

module "bootstrap" {
  source = "git::git@github.com:sourcefuse/terraform-module-aws-bootstrap?ref=1.0.1"

  providers = {
    aws = aws.backend_state
  }

  bucket_name   = var.bucket_name
  dynamodb_name = var.dynamodb_name

  tags = merge(module.tags.tags, tomap({
    Name         = var.bucket_name
    DynamoDBName = var.dynamodb_name
  }))
}
