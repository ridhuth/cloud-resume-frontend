output "redirect_distribution_domain" {
  value       = module.distributions_dev.redirect_distribution_domain
  description = "Domain name corresponding to the distribution. For example: d604721fxaaqy9.cloudfront.net"
}

output "distribution_domain" {
  value       = module.distributions_dev.distribution_domain
  description = "Domain name corresponding to the distribution. For example: d604721fxaaqy9.cloudfront.net"
}