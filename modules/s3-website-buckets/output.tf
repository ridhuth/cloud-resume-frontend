

output "s3_regional_dom_name" {
  value       = aws_s3_bucket.wwwrhresume_bucket.bucket_regional_domain_name
  description = "s3 bucket_regional_domain_name"
}

output "s3_redirect_regional_dom_name" {
  value       = aws_s3_bucket.rhresume_bucket.bucket_regional_domain_name
  description = "s3 redirect bucket_regional_domain_name"
}



output "s3_bucket_name" {
  value = aws_s3_bucket.wwwrhresume_bucket.id
}

output "s3_redirect_bucket_name" {
  value = aws_s3_bucket.rhresume_bucket.id
}