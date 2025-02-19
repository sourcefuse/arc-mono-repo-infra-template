output "bucket_id" {
  value = { for k, v in module.s3 : k => v.bucket_id }
}

output "bucket_arn" {
  value = { for k, v in module.s3 : k => v.bucket_arn }
}
