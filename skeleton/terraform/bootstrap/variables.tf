################################################################
## shared
################################################################
variable "bucket_name" {
  description = "Name of the bucket."
  default     = "sf-refarch-devops-infra-state"
  type        = string
}

variable "dynamodb_name" {
  description = "Name of the Dynamo DB lock table."
  default     = "sf_refarch_devops_infra_state"
  type        = string
}

variable "profile" {
  description = "Profile for the AWS backend state provider."
  default     = "poc2"
  type        = string
}

variable "region" {
  description = "AWS Region"
  default     = "us-east-1"
  type        = string
}
