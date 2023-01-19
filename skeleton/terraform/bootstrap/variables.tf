################################################################
## shared
################################################################
variable "project_name" {
  type        = string
  description = "Name of the project."
}

variable "bucket_name" {
  description = "Name of the bucket."
  default     = "infra-state"
  type        = string
}

variable "dynamodb_name" {
  description = "Name of the Dynamo DB lock table."
  default     = "infra_state"
  type        = string
}

variable "region" {
  description = "AWS Region"
  default     = "us-east-1"
  type        = string
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT'"
}
