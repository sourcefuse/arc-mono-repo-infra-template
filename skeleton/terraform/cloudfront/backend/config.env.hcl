region         = "${{ values.region }}"
key            = "${{ values.namespace }}//env//cloudfront/terraform.tfstate"
bucket         = "${{ values.bucketName }}"
dynamodb_table = "${{ values.dynamoDbLockTableName }}"
encrypt        = true
