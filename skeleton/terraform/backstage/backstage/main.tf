terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
  }
}

resource "kubernetes_namespace" "backstage" {
  metadata {
    annotations = {
      name = local.namespace
    }

    labels = {
      name = local.namespace
    }

    name = local.namespace
  }

  lifecycle {
    create_before_destroy = true
  }
}

################################################################
## service accounts
################################################################
resource "kubernetes_service_account" "sa" {
  metadata {
    labels = {
      name = var.service_account_name
    }
    name      = var.service_account_name
    namespace = kubernetes_namespace.backstage.metadata.0.name

    annotations = {
      app                          = var.app_name
      "eks.amazonaws.com/role-arn" = aws_iam_role.backstage_secrets.arn
    }
  }
}

################################################################
## kubectl manifests
################################################################
resource "kubectl_manifest" "secret_provider_class" {
  yaml_body = templatefile("${path.root}/backstage/manifests/SecretProviderClass.yaml", {
    app_name    = var.app_name
    namespace   = kubernetes_namespace.backstage.metadata.0.name
    environment = var.environment
  })
}

################################################################
## iam
################################################################
resource "aws_iam_policy" "backstage_secrets" {
  name        = "${var.environment}_${var.app_name}_policy"
  path        = "/"
  description = "Policy to manage access to secrets for the Backstage application"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:secretsmanager:*:*:secret:${var.environment}-${var.app_name}*",
          "arn:aws:secretsmanager:*:*:secret:${var.environment}-${var.app_name}",
        ]
      },
    ]
  })
}

resource "aws_iam_role" "backstage_secrets" {
  name = "${var.environment}_${var.app_name}_eks_assume_role"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "arn:aws:iam::${var.eks_cluster_account_id}:oidc-provider/${local.oidc_issuer_stripped}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${local.oidc_issuer_stripped}:sub" : "system:serviceaccount:${kubernetes_namespace.backstage.metadata.0.name}:${var.service_account_name}",
            "${local.oidc_issuer_stripped}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "backstage_secrets" {
  policy_arn = aws_iam_policy.backstage_secrets.arn
  role       = aws_iam_role.backstage_secrets.name
}


module "k8s_app" {
  source                         = "git@github.com:sourcefuse/terraform-k8s-app.git?ref=0.1.1"
  app_label                      = local.namespace
  container_image                = local.container_image
  container_name                 = local.namespace
  container_port                 = local.port_number
  deployment_name                = local.namespace
  namespace_name                 = kubernetes_namespace.backstage.metadata[0].name
  port                           = local.port_number
  port_name                      = local.port_number
  protocol                       = "TCP"
  service_name                   = local.service_name
  target_port                    = local.port_number
  replica_count                  = 1
  service_account_name           = kubernetes_service_account.sa.metadata[0].name
  persistent_volume_enable       = false
  persistent_volume_claim_enable = false

  env_secret_refs = [
    {
      env_var_name        = "POSTGRES_USER",
      secret_key_ref_name = local.secret_name
      secret_key_ref_key  = "POSTGRES_USER"
    },
    {
      env_var_name        = "POSTGRES_PASSWORD",
      secret_key_ref_name = local.secret_name
      secret_key_ref_key  = "POSTGRES_PASSWORD"
    },
    {
      env_var_name        = "GITHUB_TOKEN",
      secret_key_ref_name = local.secret_name
      secret_key_ref_key  = "GITHUB_TOKEN"
    },
    {
      env_var_name        = "GITHUB_CLIENT_ID",
      secret_key_ref_name = local.secret_name
      secret_key_ref_key  = "GITHUB_CLIENT_ID"
    },
    {
      env_var_name        = "GITHUB_CLIENT_SECRET",
      secret_key_ref_name = local.secret_name
      secret_key_ref_key  = "GITHUB_CLIENT_SECRET"
    }
  ]

  csi_secret_volumes = [
    {
      volume_name = var.app_name,
      mount_path  = "/mnt/secrets-store", //TODO: make var
      read_only   = true,
      driver      = "secrets-store.csi.k8s.io", //TODO: make var
      volume_attributes = {
        secretProviderClass = var.app_name
      }
    }
  ]

  environment_variables = [
    {
      name  = "POSTGRES_HOST"
      value = var.db_host
    },
    {
      name  = "POSTGRES_PORT"
      value = var.db_port
    },
    {
      name  = "BASE_URL"
      value = "https://${local.host_name}"
    },
    {
      name  = "ENVIRONMENT"
      value = "production" // TODO: make variable
    },
  ]

  depends_on = [kubectl_manifest.secret_provider_class]
}


module "ingress" {
  source       = "../../ingress"
  host_name    = local.host_name
  service_name = local.service_name
  namespace    = local.namespace
  port_number  = local.port_number

  depends_on = [module.k8s_app]
}
