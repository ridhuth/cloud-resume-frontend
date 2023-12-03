/*
output "redirect_distribution_domain" {

  value = [
    for k in module.distributions_dev : k.redirect_distribution_domain
  ]
  description = "Domain name corresponding to the distribution. For example: d604721fxaaqy9.cloudfront.net"

 }
 */

output "redirect_distribution_domain" {

    value = {
      domain_name = for k in module.distributions_dev : k.redirect_distribution_domain
      origin = for k in module.s3_bucket_dev : k.s3_redirect_bucket_name
    }
    description = "Domain name corresponding to the distribution and bucket name so appropriate test environment index is known"
  
}


output "distribution_domain" {

    value = {
      domain_name = for k in module.distributions_dev : k.distribution_domain
      origin = for k in module.s3_bucket_dev : k.s3_bucket_name
    }
    description = "Domain name corresponding to the distribution and bucket name so appropriate test environment index is known"
  
}


/*
output "distribution_domain" {

   value = [
    for k in module.distributions_dev : k.distribution_domain
  ]
  description = "Domain name corresponding to the distribution. For example: d604721fxaaqy9.cloudfront.net"

 }
*/