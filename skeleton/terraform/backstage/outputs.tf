output "oidc_issuer" {
  value = data.aws_eks_cluster.eks.identity[0].oidc[0].issuer
}
