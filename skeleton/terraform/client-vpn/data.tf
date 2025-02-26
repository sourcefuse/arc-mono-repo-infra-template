################################################
## imports
################################################
## vpc
data "aws_vpc" "this" {
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
      "${var.namespace}-${var.environment}-private-subnet-${var.region}a",
      "${var.namespace}-${var.environment}-private-subnet-${var.region}b",
      "${var.namespace}-${var.environment}-private-subnet-${var.region}c"
    ]
  }
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }
}