locals {
  map_additional_iam_roles = [
    {
      username = "admin",
      groups   = ["system:masters"],
      rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/test-poc-admin-role"
    }
  ]
}
