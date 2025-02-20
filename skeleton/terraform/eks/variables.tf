################################################################
## shared
################################################################
variable "namespace" {
  description = "Namespace for the resources."
  default     = "arc"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)

  default = [
    "us-east-1a",
    "us-east-1b"
  ]

}

variable "environment" {
  type        = string
  default     = "poc"
  description = "ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT'"
}

variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "project_name" {
  type        = string
  description = "Name of the project."
}

#######################################################
## eks / kubernetes / helm
#######################################################

variable "name" {
  type        = string
  default     = null
  description = <<-EOT
    ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.
    This is the only ID element not also included as a `tag`.
    The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input.
    EOT
}

variable "kubernetes_version" {
  description = "Desired Kubernetes master version. If you do not specify a value, the latest available version is used"
  type        = string
  default     = "1.32"
}

variable "kubernetes_namespace" {
  description = "Default k8s namespace to create"
  type        = string
  default     = "arc"
}

variable "map_additional_iam_roles" {
  description = "Additional IAM roles to add to `config-map-aws-auth` ConfigMap"

  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = []
}

variable "instance_types" {
  description = "Set of instance types associated with the EKS Node Group. Defaults to [\"t3.medium\"]. Terraform will only perform drift detection if a configuration value is provided"
  type        = list(string)

  default = ["t3.medium"]
}

variable "desired_size" {
  description = "Desired number of worker nodes."
  type        = number

  default = 2
}

variable "min_size" {
  description = "The minimum size of the AutoScaling Group."
  type        = number

  default = 2
}

variable "max_size" {
  description = "The maximum size of the AutoScaling Group."
  type        = number

  default = 4
}