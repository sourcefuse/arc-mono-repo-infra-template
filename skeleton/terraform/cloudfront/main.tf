module "tags" {
  source  = "sourcefuse/arc-tags/aws"
  version = "1.2.7"

  environment = var.environment
  project     = var.project_name

  extra_tags = {
    MonoRepo = "true"
  }
}

module "cloudfront" {
  source  = "sourcefuse/arc-cloudfront/aws"
  version = "4.1.4"
  providers = {
    aws.acm = aws.acm // Certificate has to be created in us-east-1 region
  }

  origins = local.origins

  namespace              = var.namespace
  description            = "This is a test Cloudfront distribution"
  route53_root_domain    = "${{ values.route53Domain }}"
  create_route53_records = var.create_route53_records
  aliases                = ["cf.${{ values.route53Domain }}"]
  enable_logging         = var.enable_logging // Create a new S3 bucket for storing Cloudfront logs

  default_cache_behavior = local.default_cache_behavior

  viewer_certificate = {
    cloudfront_default_certificate = false // false :  It will create ACM certificate with details provided in acm_details
    minimum_protocol_version       = "TLSv1.2_2018"
    ssl_support_method             = "sni-only"
  }

  acm_details = {
    domain_name               = "*.${{ values.route53Domain }}",
    subject_alternative_names = ["cf.${{ values.route53Domain }}"]
  }

  custom_error_responses = [{
    error_caching_min_ttl = 10,
    error_code            = "404", // should be unique
    response_code         = "200",
    response_page_path    = "/index.html"
  }]

  s3_kms_details = {
    s3_bucket_encryption_type = "SSE-S3", //Encryption for S3 bucket , options : `SSE-S3` , `SSE-KMS`
    kms_key_administrators    = [],
    kms_key_users             = [], // Note :- Add users/roles who wanted to read/write to S3 bucket
    kms_key_arn               = null
  }

  response_headers_policy = local.response_headers_policy

  tags = module.tags.tags

}
