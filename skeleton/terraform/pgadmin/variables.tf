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

variable "route_53_zone" {
  type        = string
  description = "Route 53 domain to create A records for individual applications running in EKS."
}
