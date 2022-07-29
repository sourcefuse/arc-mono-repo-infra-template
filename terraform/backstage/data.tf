data "aws_caller_identity" "current" {}

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

// TODO: replace with more secure method
data "aws_ssm_parameter" "db_cluster_endpoint" {
  name            = var.db_cluster_endpoint
  with_decryption = true
}

data "aws_ssm_parameter" "db_cluster_user" {
  name            = var.db_cluster_user
  with_decryption = true
}

data "aws_ssm_parameter" "db_cluster_password" {
  name            = var.db_cluster_password
  with_decryption = true
}

data "aws_ssm_parameter" "github_token" {
  name            = var.github_token
  with_decryption = true
}

data "aws_ssm_parameter" "github_client_id" {
  name            = var.github_client_id
  with_decryption = true
}

data "aws_ssm_parameter" "github_client_secret" {
  name            = var.github_client_secret
  with_decryption = true
}

data "aws_ecr_repository" "backstage_image_repo" {
  name = var.image_repo_name
}
