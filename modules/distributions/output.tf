output "acm_certificate_arn" {
  value       = terraform.workspace == "prod" ? aws_acm_certificate.cert[0].arn : null
  description = "acm_certificate_arn"
}

output "redirect_distribution_domain" {
  value       = aws_cloudfront_distribution.s3_redirect_distribution.domain_name
  description = "Domain name corresponding to the distribution. For example: d604721fxaaqy9.cloudfront.net"
}

output "distribution_domain" {
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
  description = "Domain name corresponding to the distribution. For example: d604721fxaaqy9.cloudfront.net"
}

output "origin_access_identity" {
  value = aws_cloudfront_origin_access_identity.origin_access.iam_arn
  description = "A pre-generated ARN for use in S3 bucket policies (see below). Example: arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity E2QWRUHAPOMQZL"
}

output "redirect_distribution_id" {
  value = aws_cloudfront_distribution.s3_redirect_distribution.id
}