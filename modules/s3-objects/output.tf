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