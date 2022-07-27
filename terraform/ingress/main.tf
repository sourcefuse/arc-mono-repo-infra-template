terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

resource "kubectl_manifest" "ingress" {
  yaml_body = templatefile("${path.module}/manifests/ingress.yaml", {
    host_name    = var.host_name
    service_name = var.service_name
    namespace    = var.namespace
    port_number  = var.port_number
  })
}
