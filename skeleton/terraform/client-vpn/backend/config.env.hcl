region         = "${{ values.region }}"
key            = "${{ values.namespace }}//env//client-vpn/terraform.tfstate"
bucket         = "${{ values.bucketName }}"
dynamodb_table = "${{ values.dynamoDbLockTableName }}"
encrypt        = true
