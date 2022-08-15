variable "environment" {
  type        = string
  description = "ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT'"
}
variable "eks_cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "eks_cluster_oidc_issuer" {
  type        = string
  description = "EKS Cluster OIDC Provider issuer URL"
}

variable "eks_cluster_account_id" {
  type        = string
  description = "EKS Cluster account ID"
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region"
}

variable "db_host" {
  type        = string
  description = "SSM param name for the DB cluster"
}

variable "db_user" {
  type        = string
  description = "SSM param name for the DB cluster service account user"
}

variable "db_password" {
  type        = string
  description = "SSM param name for the DB cluster service account password"
}

variable "db_port" {
  default     = 5432
  type        = number
  description = "Port of the database"
}

variable "github_token" {
  type        = string
  description = "SSM param name for the GitHub service account token used for GH integrations."
}

variable "github_client_id" {
  type        = string
  description = "SSM param name for the  GitHub OAuth 2.0 app client_id"
}

variable "github_client_secret" {
  type        = string
  description = "SSM param name for the GitHub OAuth 2.0 app client_id"
}

variable "container_image" {
  type        = string
  description = "url for image being used to setup backstage"
  default     = "spotify/backstage-cookiecutter"
}

variable "service_account_name" {
  description = "Name of the k8s service account"
  type        = string
}

variable "app_name" {
  description = "`app` annotation value"
  type        = string
}

variable "k8s_namespace" {
  description = "k8s Namespace"
  type        = string
}

variable "app_port_number" {
  description = "Port number for the container to run under"
  type        = number
}

variable "app_host_name" {
  description = "Host name to expose via Route53"
  type        = string
}
