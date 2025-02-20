locals {
  buckets = {
    "${var.namespace}-${var.environment}-bucket1" = {
      name              = "${var.namespace}-${var.environment}-bucket1"
      acl               = "private"
      enable_versioning = true
    }
  }
}
