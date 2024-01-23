################################################################
## shared
################################################################
variable "namespace" {
  description = "Namespace for the resources."
  default     = "arc"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT'"
}

variable "project_name" {
  type        = string
  description = "Name of the project."
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)

  default = [
    "us-east-1a",
    "us-east-1b"
  ]
}

variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}
