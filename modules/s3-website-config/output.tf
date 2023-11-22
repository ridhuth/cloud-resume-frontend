output "s3_redirect_website_endpoint" {
  value       = aws_s3_bucket_website_configuration.s3_redirect_domain.website_endpoint
  description = "s3 redirect Website endpoint"
}