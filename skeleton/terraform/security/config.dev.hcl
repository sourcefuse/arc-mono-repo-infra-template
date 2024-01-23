region         = "${{ values.region }}"
key            = "${{ values.component_id }}-security/terraform.tfstate"
bucket         = "${{ values.bucket_name }}"
dynamodb_table = "${{ values.dynamodb_lock_table_name }}"
encrypt        = true
