data "aws_route53_zone" "default_domain" {
  name = var.route_53_zone
}

data "aws_lb" "eks_nlb" {
  tags = {
    Name = var.cluster_name
  }
}

data "aws_eks_cluster" "eks" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "eks" {
  name = var.cluster_name
}
