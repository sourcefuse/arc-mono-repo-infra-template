terraform {
  required_version = "~> 1.3, < 2.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.20"
    }
  }

  backend "s3" {}
}

provider "aws" {
  region = var.region
}