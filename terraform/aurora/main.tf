// TODO: make ticket for adding injectable tags to DB module
module "tags" {
  source = "git@github.com:sourcefuse/terraform-aws-refarch-tags?ref=1.0.1"

  environment = terraform.workspace
  project     = "refarch-devops-infra-db"

  extra_tags = {
    MonoRepo     = "True"
    MonoRepoPath = "terraform/resources/aurora"
  }
}

provider "aws" {
  region  = var.region
  profile = var.profile
}

module "ref_arch_db" {
  source              = "git@github.com:sourcefuse/terraform-aws-ref-arch-db?ref=1.1.0"
  region              = var.region
  subnets             = data.aws_subnet_ids.private.ids
  vpc_id              = data.aws_vpc.vpc.id
  db_admin_username   = var.db_admin_username
  environment         = var.environment
  namespace           = var.namespace
  cluster_size        = var.cluster_size
  name                = var.name
  allowed_cidr_blocks = [data.aws_vpc.vpc.cidr_block]
}
