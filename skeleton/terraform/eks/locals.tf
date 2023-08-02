locals {
  vpc_name = "${var.namespace}-${var.environment}-vpc"
  private_subnet_names = [
    "${var.namespace}-${var.environment}-private-subnet-private-${var.region}a",
    "${var.namespace}-${var.environment}-private-subnet-private-${var.region}b"
  ]
  public_subnet_names = [
    "${var.namespace}-${var.environment}-public-subnet-public-${var.region}a",
    "${var.namespace}-${var.environment}-public-subnet-public-${var.region}b"
  ]
}
