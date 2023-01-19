# ${{ values.component_id | dump }} Infrastructure  

## Overview

Mono repo containing all infrastructure configuration.  

## Usage 
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

* SourceFuse DevOps
