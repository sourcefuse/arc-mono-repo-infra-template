region       = "${{ values.region }}"
cluster_name = "${{ values.clusterName }}"
environment  = "${{ values.environment }}"

# db ssm params
db_cluster_endpoint = "${{ values.dbClusterEndpoint }}"
db_cluster_user     = "${{ values.dbClusterUser }}"
db_cluster_password = "${{ values.dbClusterPassword }}"

# github params
github_token         = "${{ values.githubToken }}"
github_client_id     = "${{ values.githubClientId }}"
github_client_secret = "${{ values.githubClientSecret }}"

route_53_zone   = "${{ values.route53Zone }}"
app_domains     = ["dx.sfrefarch.com"]  // TODO - update this to use values
image_repo_name = "${{ values.imageRepoName }}"
