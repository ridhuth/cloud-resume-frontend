

output "redirect_distribution_domain" {
  value       = aws_cloudfront_distribution.s3_redirect_distribution.domain_name
  description = "Domain name corresponding to the distribution. For example: d604721fxaaqy9.cloudfront.net"
}

output "distribution_domain" {
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
  description = "Domain name corresponding to the distribution. For example: d604721fxaaqy9.cloudfront.net"
}


output "redirect_distribution_id" {
  value = aws_cloudfront_distribution.s3_redirect_distribution.id
}

output "distribution_id" {
  value = aws_cloudfront_distribution.s3_distribution.id
}