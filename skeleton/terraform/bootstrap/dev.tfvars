region        = "${{ values.region }}"
profile       = "${{ values.profile }}"
bucket_name   = "${{ values.bucket_name }}"
dynamodb_name = "${{ values.dynamodb_lock_table_name }}"
// TODO: hook up to tags and make uniform in all modules
tags          = {
  Environment = "dev"
  ENV         = "dev"
  Project     = "${{ values.component_id }}"
  Creator     = "terraform"
}
