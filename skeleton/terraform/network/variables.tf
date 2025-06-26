################################################################
## shared
################################################################
variable "project_name" {
  type        = string
  description = "Name of the project."
}

variable "namespace" {
  type        = string
  description = "Namespace for the resources."
  default     = "refarchdevops" // TODO: update me
}

variable "region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT'"
}

################################################################
## networking
################################################################
variable "availability_zones" {
  description = "List of availability zones to deploy resources in."
  type        = list(string)

  default = [
    "us-east-1a",
    "us-east-1b"
  ]
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC to use."
  default     = "10.0.0.0/16"
}
