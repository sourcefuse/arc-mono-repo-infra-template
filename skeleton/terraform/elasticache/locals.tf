locals {
  private_subnet_cidr = [for s in data.aws_subnet.subnet : s.cidr_block]
}
