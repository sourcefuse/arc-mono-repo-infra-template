// TODO: come back to entire file - not correctly mapped and some have to exist up stream first
region       = "${{ values.region }}"
cluster_name = "${{ values.clusterName }}"
environment  = "${{ values.iac_environment }}"

# db ssm params
db_cluster_endpoint = "${{ values.dbClusterEndpoint }}"
db_cluster_user     = "${{ values.dbClusterUser }}"
db_cluster_password = "${{ values.dbClusterPassword }}"

# github params
github_token         = "${{ values.githubToken }}"
github_client_id     = "${{ values.githubClientId }}"
github_client_secret = "${{ values.githubClientSecret }}"

route_53_zone   = "${{ values.default_route53_zone }}"
app_domains     = ["${{ parameters.default_route53_zone }}"]
image_repo_name = "${{ values.imageRepoName }}"
