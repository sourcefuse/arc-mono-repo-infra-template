environment        = "${{ values.environment }}"
namespace          = "${{ values.namespace }}"
region             = "${{ values.region }}"
availability_zones = ["${{ values.region }}a", "${{ values.region }}b"]
vpc_cidr_block     = "${{ values.vpc_cidr_block }}"
project_name       = "${{ values.component_id }}"
