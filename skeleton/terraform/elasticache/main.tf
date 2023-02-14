module "tags" {
  source = "git::https://github.com/sourcefuse/terraform-aws-refarch-tags?ref=1.1.0"

  environment = var.environment
  project     = var.project_name

  extra_tags = {
    MonoRepo     = "True"
    MonoRepoPath = "terraform/resources/elasticache"
  }
}

module "redis" {
  source  = "cloudposse/elasticache-redis/aws"
  version = "0.49.0"

  namespace                  = var.namespace
  environment                = var.environment
  vpc_id                     = data.aws_vpc.vpc.id
  allowed_security_group_ids = data.aws_security_groups.redis_user_sg.ids
  subnets                    = data.aws_subnets.private.ids
  apply_immediately          = true
  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
  description                = "Elasticache Redis instance for ${var.project_name}"

  tags = module.tags.tags
}

resource "aws_security_group" "ec_security_group" {
  name        = "${var.namespace}-${var.environment}-redis-user"
  description = "Security Group for ElastiCache Redis users"
  vpc_id      = data.aws_vpc.vpc.id

  egress {
    from_port   = 0
    to_port     = 6379
    protocol    = "TCP"
    cidr_blocks = local.private_subnet_cidr
    description = "Rule to allow Redis users to access the Redis cluster"
  }
  tags = {
    Name       = "${var.namespace}-${var.environment}-redis-user"
    redis-user = "yes"
  }
}
