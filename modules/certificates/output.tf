output "acm_certificate_arn" {
  value       = terraform.workspace == "prod" ? aws_acm_certificate.cert.arn : null
  description = "acm_certificate_arn"
}