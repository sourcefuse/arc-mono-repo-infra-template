locals {
  private_subnet_cidr = [for s in data.aws_subnet.private : s.cidr_block]
  public_subnet_cidr  = [for s in data.aws_subnet.public : s.cidr_block]
}
