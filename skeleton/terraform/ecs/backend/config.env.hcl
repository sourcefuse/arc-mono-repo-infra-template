region         = "${{ values.region }}"
key            = "${{ values.namespace }}//env//ecs/terraform.tfstate"
bucket         = "${{ values.bucketName }}"
dynamodb_table = "${{ values.dynamoDbLockTableName }}"
encrypt        = true
