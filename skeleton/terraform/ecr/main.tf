module "tags" {
  source = "git@github.com:sourcefuse/terraform-aws-refarch-tags?ref=1.0.1"

  environment = terraform.workspace
  project     = "refarch-devops-infra"

  extra_tags = {
    MonoRepo     = "True"
    MonoRepoPath = "terraform/resources/ecr"
  }
}

module "ecr" {
  source    = "cloudposse/ecr/aws"
  version   = "0.32.3"
  namespace = "sf-refarch"
  stage     = var.environment
  for_each  = local.ecr_repos
  name      = each.value.name
  tags      = module.tags.tags
}
