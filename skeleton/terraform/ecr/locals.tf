locals {
  ecr_repos = {
    backstage = {
      name = "${var.namespace}-${var.environment}-backstage"
    }
  }
}
