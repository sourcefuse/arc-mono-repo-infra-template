terraform {
  required_version = "~> 1.1.3"

  backend "s3" {
    region         = "us-east-1"
    key            = "refarch-devops-infra-pgadmin/terraform.tfstate"
    bucket         = "sf-refarch-devops-infra-state"
    dynamodb_table = "sf_refarch_devops_infra_state"
    encrypt        = true
  }
}
