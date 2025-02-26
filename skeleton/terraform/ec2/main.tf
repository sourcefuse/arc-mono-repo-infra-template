################################################################################
## defaults
################################################################################
terraform {
  required_version = "~> 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
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
    MonoRepoPath = "terraform/ec2"
  }
}

module "ec2_instances" {
  source  = "sourcefuse/arc-ec2/aws"
  version = "0.0.2"

  name                  = "${var.namespace}-${var.environment}-test"
  instance_type         = "t3.small"
  ami_id                = data.aws_ami.amazon_linux.id
  vpc_id                = data.aws_vpc.this.id
  subnet_id             = "subnet-066d0c78479b72e77"
  instance_profile_data = local.instance_profile_data
  security_group_data   = local.security_group_data

  root_block_device_data = {
    volume_size = 10
    volume_type = "gp3"
  }
  additional_ebs_volumes = local.additional_ebs_volumes

  load_balancer_data = local.load_balancer_data
  target_groups      = local.target_groups

  tags = module.terraform-aws-arc-tags.tags

}