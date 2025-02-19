################################################################################
## defaults
################################################################################
terraform {
  required_version = "~> 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {}
}

provider "aws" {
  region = var.region
}

module "terraform-aws-arc-tags" {
  source      = "sourcefuse/arc-tags/aws"
  version     = "1.2.7"
  environment = var.environment
  project     = var.project_name

  extra_tags = {
    MonoRepo     = "True"
    MonoRepoPath = "terraform/ecs"
  }
}

################################################################################
## ecs
################################################################################
module "ecs" {
  source  = "sourcefuse/arc-ecs/aws"
  version = "1.6.0"

  ## ecs cluster
  ecs_cluster = {
    name = "${var.namespace}-ecs-module-${var.environment}"
    configuration = {
      execute_command_configuration = {
        logging = "OVERRIDE"
        log_configuration = {
          log_group_name = "${var.namespace}-${var.environment}-cluster-log-group"
        }
      }
    }
    create_cloudwatch_log_group = true
    service_connect_defaults    = {}
    settings                    = []
  }

  capacity_provider = {
    autoscaling_capacity_providers = {}
    use_fargate                    = true
    fargate_capacity_providers = {
      fargate_cp = {
        name = "FARGATE"
      }
    }
  }

  ## ecs service
  vpc_id      = data.aws_vpc.vpc.id
  environment = var.environment

  ecs_service = {
    cluster_name             = "${var.namespace}-ecs-module-${var.environment}"
    service_name             = "${var.namespace}-ecs-module-service-${var.environment}"
    repository_name          = "12345.dkr.ecr.us-east-1.amazonaws.com/arc/arc-poc-ecs"
    enable_load_balancer     = false
    aws_lb_target_group_name = "${var.namespace}-${var.environment}-alb-tg"
    create_service           = false
  }

  task = {
    tasks_desired        = 1
    container_port       = 80
    container_memory     = 1024
    container_vcpu       = 256
    container_definition = "container/container_definition.json.tftpl"
  }

  lb = {
    name              = "${var.namespace}-${var.environment}-alb"
    listener_port     = 80
    security_group_id = "sg-12345"
  }

  ## ALB
  cidr_blocks = null

  alb = {
    name       = "${var.namespace}-${var.environment}-alb"
    internal   = false
    port       = 80
    create_alb = false
  }

  alb_target_group = [{
    name        = "${var.namespace}-${var.environment}-alb-tg"
    port        = 80
    protocol    = "HTTP"
    vpc_id      = data.aws_vpc.vpc.id
    target_type = "ip"
    health_check = {
      enabled = true
      path    = "/"
    }
    stickiness = {
      enabled = true
      type    = "lb_cookie"
    }
  }]

  listener_rules = []
}

