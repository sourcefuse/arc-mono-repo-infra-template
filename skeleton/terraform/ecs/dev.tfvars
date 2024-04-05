region          = "${{ values.region }}"
environment     = "${{ values.iac_environment }}"
acm_domain_name = "${{ values.default_route53_zone }}"
project_name    = "${{ values.component_id }}"
container_image = "757583164619.dkr.ecr.us-east-1.amazonaws.com/sf-refarch-dev-sourcefuse-backstage:0.3.8"
namespace       = "${{ values.iac_namespace }}"
