region        = "${{ values.region }}"
cluster_name  = "${{ values.iac_namespace }}-${{ values.iac_environment }}-${{ values.iac_suffix }}-cluster" // TODO: figure out how to determine me
route_53_zone = "${{ values.default_route53_zone }}"
