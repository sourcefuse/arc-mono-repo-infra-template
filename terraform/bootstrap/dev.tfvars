region                   = "${{ values.region }}"
profile                  = "${{ values.profile }}"
bucket_name              = "${{ values.bucket_name }}"
dynamodb_lock_table_name = "${{ values.dynamodb_lock_table_name }}"
tags                     = {
  Environment = "dev"
  ENV         = "dev"
  Project     = "${{ values.component_id }}"
  Creator     = "terraform"
}
