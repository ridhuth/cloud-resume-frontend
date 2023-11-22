output "index_html_etag" {
  value       = aws_s3_object.object.etag
  description = "etag for index.html"
}

output "counter_js_etag" {
  value       = aws_s3_object.visitor_counter_object.etag
  description = "etag for js scrip"
}

output "style_css_etag" {
  value       = aws_s3_object.style_object.etag
  description = "etag for style.css"
}

output "s3_regional_dom_name" {
  value       = aws_s3_bucket.wwwrhresume_bucket.bucket_regional_domain_name
  description = "s3 bucket_regional_domain_name"
}

output "s3_redirect_regional_dom_name" {
  value       = aws_s3_bucket.rhresume_bucket.bucket_regional_domain_name
  description = "s3 redirect bucket_regional_domain_name"
}

output "s3_redirect_website_endpoint" {
  value       = aws_s3_bucket_website_configuration.s3_redirect_domain.website_endpoint
  description = "s3 redirect Website endpoint"
}

output "s3_bucket_name" {
  value = aws_s3_bucket.wwwrhresume_bucket.id
}

output "s3_redirect_bucket_name" {
  value = aws_s3_bucket.rhresume_bucket.id
}