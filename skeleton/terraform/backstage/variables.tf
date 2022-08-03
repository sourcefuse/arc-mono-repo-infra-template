variable "environment" {
  type        = string
  default     = "dev"
  description = "ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT'"
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region"
}

variable "profile" {
  type        = string
  default     = "default"
  description = "Name of the AWS profile to use"
}

variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "db_cluster_endpoint" {
  type        = string
  description = "SSM param name for the DB cluster"
}

variable "db_cluster_user" {
  type        = string
  description = "SSM param name for the DB cluster service account user"
}

variable "db_cluster_password" {
  type        = string
  description = "SSM param name for the DB cluster service account password"
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

variable "route_53_zone" {
  type        = string
  description = "Route 53 domain to create A records for individual applications running in EKS."
}

variable "image_repo_name" {
  type        = string
  description = "name of the ecr repo. this is used to filter the repo url. this repo must exist"
}

variable "image_tag" {
  type        = string
  description = "image tag to be deployed. this tag much exist in the image repo."
  default     = "0.1.3"
}

variable "app_domains" {
  type        = list(string)
  description = "Domains used to create A records for the applications"
}
