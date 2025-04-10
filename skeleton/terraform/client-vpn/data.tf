################################################
## imports
################################################
## vpc
data "aws_vpc" "this" {
  filter {
    name   = "tag:Name"
    values = ["${var.project_name}-${var.environment}-vpc"]
  }
}

## network
data "aws_subnets" "private" {
  filter {
    name = "tag:Name"
    values = [
      "${var.project_name}-${var.environment}-private-subnet-private-${var.region}a",
      "${var.project_name}-${var.environment}-private-subnet-private-${var.region}b",
    ]
  }
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }
}