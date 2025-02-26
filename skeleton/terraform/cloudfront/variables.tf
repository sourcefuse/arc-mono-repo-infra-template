variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "namespace" {
  type        = string
  description = "Namespace for the resources."
}

variable "environment" {
  type        = string
  description = "ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT'"
}

variable "enable_logging" {
  type        = bool
  description = "Enable logging for Cloudfront destribution, this will create new S3 bucket"
  default     = false
}

variable "create_route53_records" {
  type        = bool
  description = "made optional route53"
  default     = true
}

variable "project_name" {
  type        = string
  description = "Name of the project."
}
