region         = "${{ values.region }}"
key            = "${{ values.namespace }}//env//ec2/terraform.tfstate"
bucket         = "${{ values.bucketName }}"
dynamodb_table = "${{ values.dynamoDbLockTableName }}"
encrypt        = true
