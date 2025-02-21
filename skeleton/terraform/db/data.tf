################################################################################
## imports
################################################################################
data "aws_caller_identity" "this" {}

## network
data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["${var.namespace}-${var.environment}-vpc"]
  }
}

data "aws_subnets" "private" {
  filter {
    name = "tag:Name"

    values = [
      "${var.namespace}-${terraform.workspace}-private-${var.region}a",
      "${var.namespace}-${terraform.workspace}-private-${var.region}b",
    ]
  }
}
