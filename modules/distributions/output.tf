output "acm_certificate_arn" {
  value       = terraform.workspace == "default" ? aws_acm_certificate.cert[0].arn : null
  description = "acm_certificate_arn"
}

output "distribution_domain" {
  value       = aws_cloudfront_distribution.s3_redirect_distribution.domain_name
  description = "Domain name corresponding to the distribution. For example: d604721fxaaqy9.cloudfront.net"
}

output "origin_access_identity" {
  value = aws_cloudfront_origin_access_identity.origin_access.iam_arn
  description = "A pre-generated ARN for use in S3 bucket policies (see below). Example: arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity E2QWRUHAPOMQZL"
}