output "acm_certificate_arn" {
  value       = terraform.workspace == "default" ? aws_acm_certificate.cert[0].arn : null
  description = "acm_certificate_arn"
}

output "distribution_domain" {
  value       = aws_cloudfront_distribution.s3_redirect_distribution.domain_name
  description = "Domain name corresponding to the distribution. For example: d604721fxaaqy9.cloudfront.net"
}