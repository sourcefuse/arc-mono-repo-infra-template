## network
data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["${var.namespace}-${var.environment}-vpc"]
  }
}

## network
data "aws_subnets" "private" {
  filter {
    name = "tag:Name"

    values = [
      "${var.namespace}-${var.environment}-privatesubnet-private-${var.region}a",
      "${var.namespace}-${var.environment}-privatesubnet-private-${var.region}b"
    ]
  }
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
}

data "aws_subnet" "subnet" {
  for_each = toset(data.aws_subnets.private.ids)
  id       = each.value
}

## security
data "aws_security_groups" "redis_user_sg" {
  filter {
    name   = "tag:redis-user"
    values = ["yes"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
}
