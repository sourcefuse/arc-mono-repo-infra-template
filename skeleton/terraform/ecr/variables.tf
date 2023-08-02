################################################################################
## shared
################################################################################
variable "project_name" {
  type        = string
  description = "Name of the project."
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT'"
}

variable "namespace" {
  type        = string
  description = "Namespace for the resources."
  default     = "demo"
}

variable "profile" {
  type        = string
  default     = "default"
  description = "Name of the AWS profile to use"
}
