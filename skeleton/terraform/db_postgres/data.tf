################################################################################
## imports
################################################################################
data "aws_caller_identity" "this" {}

## VPC
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
      "*private*"
    ]
  }
}
