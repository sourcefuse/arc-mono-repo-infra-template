region         = "${{ values.region }}"
key            = "${{ values.namespace }}//env//cache/terraform.tfstate"
bucket         = "${{ values.bucketName }}"
dynamodb_table = "${{ values.dynamoDbLockTableName }}"
encrypt        = true
