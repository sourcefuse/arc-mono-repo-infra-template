variable "host_name" {
  description = "Hostname for the ingress"
  type        = string
}

variable "service_name" {
  description = "k8s service name"
  type        = string
}

variable "namespace" {
  description = "k8s namespace"
  type        = string
}

variable "port_number" {
  description = "port number"
  type        = string
}
