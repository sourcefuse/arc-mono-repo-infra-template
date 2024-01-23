# ${{ values.component_id | dump }} Infrastructure Mono Repo

## Overview

Mono repo utilized by the SourceFuse ARC Team for rapid development and deployment of infrastructure. The repository contains implementations of the core ARC Reference Architectures and IaC.

Modules in the `terraform` directory

* `aurora` - Utilizes ARC IaC to provision a serverless Aurora PostgreSQL database.
* `bootstrap` - The first module that is run in any net new infrastructure environment. ARC IaC module that creates the S3 bucket and DynamoDB table for Terraform state, as well as any other helpful infrastructure management components that are helpful early in an IaC rollout.
* `ecr` - ECR repositories used by services in ECS and EKS.
* `ecs` - Utilizes ARC IaC to create an ECS cluster.
* `eks` - Utilizes ARC IaC to create an EKS cluster.
* `elasticache` - Utilizes the CloudPosse ElastiCache module to instantiate clusters.
* `ingress` - k8s Ingress module utilized by other modules for creating service specific ingress. Slated to be moved to an upstream repository.
* `network` - Utilizes ARC IaC to create an AWS network stack.
* `security` - Utilizes ARC IaC to create a security stack.
* `pgadmin` - k8s IaC to deploy pgAdmin to an EKS cluster to simplify DB administration.
* `waf` - WAF implementation attached to any load balancers created for the `eks` or `ecs` modules.

## Deploying

Make the deployment script executable.

```
$ chmod +x ./terraform-apply.sh
```

Set your AWS profile

```
$ export AWS_PROFILE=<env_profile>
```

Run the script with your desired command.

```
$ ./terraform-apply.sh -h
Execute terraform plan / apply on single or all directories.
Execute recursive cleanup on terraform cache.

Syntax: [-h|p|P|r|C|a|A|w]
options:
h     Print this help menu.
p     Optional: Execute terraform plan.
P     Optional: Recursively execute plan on ALL terraform directories, in the correct order.
r     Optional: The name of the resource (directory) in the terraform folder.
C     Optional: Cleanup the terraform cache. Default is "false".
a     Optional: Execute terraform apply.
A     Optional: Recursively execute plan and apply on ALL terraform directories, in the correct order.
w     Optional: Terraform workspace where the resources are located. Default is "dev".

```

You can execute the resources from the root of this repo, all that is required is for the `AWS_PROFILE` to be set to the correct account.  

Using the script at the root of this repo:  
1. Create a plan file. This will output to the resources subdirectory in `tf-data/`:  
  ```
  ./terraform-apply.sh -w dev -r <resource_name> -p
  ```
2. Apply the plan file. This will use the plan file that was in `tf-data/`:  
  ```
  ./terraform-apply.sh -w dev -r <resource_name> -a
  ```

## Development

### Prerequisites

- [terraform](https://learn.hashicorp.com/terraform/getting-started/install#installing-terraform)
- [terraform-docs](https://github.com/segmentio/terraform-docs)
- [pre-commit](https://pre-commit.com/#install)

### Configurations

- Configure pre-commit hooks
```sh
pre-commit install
```

## Authors

This project is authored by:  

* SourceFuse ARC Team
