################################################################
## shared
################################################################
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

variable "profile" {
  description = "Profile for the AWS backend state provider."
  default     = "default"
  type        = string
}

variable "region" {
  description = "AWS Region"
  default     = "us-east-1"
  type        = string
}
