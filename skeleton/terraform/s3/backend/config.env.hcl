region         = "${{ values.region }}"
key            = "${{ values.namespace }}//env//s3/terraform.tfstate"
bucket         = "${{ values.bucketName }}"
dynamodb_table = "${{ values.dynamoDbLockTableName }}"
encrypt        = true
