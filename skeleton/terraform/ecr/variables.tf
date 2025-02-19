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

################################################################################
## ECR
################################################################################

variable "image_tag_mutability" {
  type        = string
  description = "The tag mutability setting for the repository. Must be one of: `MUTABLE` or `IMMUTABLE`"
  default     = "MUTABLE"
}

variable "scan_images_on_push" {
  type        = bool
  default     = false
  description = "Indicates whether images are scanned after being pushed to the repository (true) or not (false)"
}