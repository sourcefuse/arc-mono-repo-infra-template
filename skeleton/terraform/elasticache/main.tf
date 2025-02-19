module "terraform-aws-arc-tags" {
  source      = "sourcefuse/arc-tags/aws"
  version     = "1.2.7"
  environment = var.environment
  project     = var.project_name

  extra_tags = {
    MonoRepo     = "True"
    MonoRepoPath = "terraform/elasticache"
  }
}

resource "aws_cloudwatch_log_group" "default" {
  name              = var.cloudwatch_logs_log_group_name
  retention_in_days = var.retention_in_days
  tags              = module.terraform-aws-arc-tags.tags
}

module "elasticache-redis" {
  source               = "sourcefuse/arc-cache/aws"
  version              = "0.0.4"
  name                 = var.name
  subnet_ids           = data.aws_subnets.private.ids
  vpc_id               = data.aws_vpc.vpc.id
  security_group_rules = var.security_group_rules


  log_delivery_configuration = [
    {
      destination      = aws_cloudwatch_log_group.default.name
      destination_type = "cloudwatch-logs"
      log_format       = "json"
      log_type         = "engine-log"
    }
  ]

  tags = module.terraform-aws-arc-tags.tags
}
