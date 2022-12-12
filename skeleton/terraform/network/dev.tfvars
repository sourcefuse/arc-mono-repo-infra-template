profile            = "${{ values.profile }}"
environment        = "${{ values.iac_environment }}"
namespace          = "${{ values.iac_namespace }}"
region             = "${{ values.region }}"
availability_zones = ["${{ values.region }}a", "${{ values.region }}b"]
vpc_cidr_block     = "${{ values.vpc_cidr_block }}"
