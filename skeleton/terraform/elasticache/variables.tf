################################################################
## shared
################################################################
variable "namespace" {
  description = "Namespace for the resources."
  default     = "arc"
}

variable "environment" {
  type        = string
  default     = "poc"
  description = "ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT'"
}

variable "project_name" {
  type        = string
  description = "Name of the project."
}

variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

################################################################
## elasticache variables
################################################################
variable "name" {
  type        = string
  description = "Name of elasticache redis"
}

variable "security_group_rules" {
  type = object({
    ingress = map(object({
      description       = optional(string)
      from_port         = number
      to_port           = number
      protocol          = string
      cidr_blocks       = optional(list(string))
      security_group_id = optional(list(string))
      ipv6_cidr_blocks  = optional(list(string))
      self              = optional(bool)
    }))
    egress = map(object({
      description       = optional(string)
      from_port         = number
      to_port           = number
      protocol          = string
      cidr_blocks       = optional(list(string))
      security_group_id = optional(list(string))
      ipv6_cidr_blocks  = optional(list(string))
    }))
  })
  description = "Ingress and egress rules for the security groups."
  default = {
    ingress = {},
    egress  = {}
  }
}

variable "retention_in_days" {
  description = "Number of days you want to retain log events in the log group"
  type        = number
  default     = "30"
}

variable "cloudwatch_logs_log_group_name" {
  default     = "/logs/elasticcache-redis"
  type        = string
  description = "name of the log group"
}