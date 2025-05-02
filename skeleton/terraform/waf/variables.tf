################################################################################
## shared
################################################################################
variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region"
}

variable "namespace" {
  type        = string
  description = "Namespace for the resources."
  default     = "arc"
}

variable "environment" {
  type        = string
  description = "Name of the environment resources will belong to."
}

variable "project_name" {
  type        = string
  description = "Name of the project."
}

variable "web_acl_rules" {
  type        = any
  description = "Rule blocks used to identify the web requests that you want to allow, block, or count"
  default     = []
}