################################################################################
## shared
################################################################################
variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "namespace" {
  type        = string
  description = "Namespace to assign the resources"
  default     = "test"
}

variable "environment" {
  description = "Name of the environment the resource belongs to."
  type        = string
  default     = "poc"
}

variable "project_name" {
  description = "Name of the project the vpn resource belongs to."
  type        = string
  default     = "arc"
}

variable "name" {
  description = "Name of the VPC."
  type        = string
  default = "arc-poc-vpc"
}

variable "type" {
  description = "type of subnet"
  type        = string
  default = "private"
}
