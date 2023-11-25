

data "aws_caller_identity" "global" {
  provider = aws.global
}

data "aws_caller_identity" "dev" {
  provider = aws.dev
}

variable "pull_requests" {
  description = "list of open pull_requests."
  type        = list(string)
}

locals {
  pull_requests = [
    toset(var.pull_requests),1
  ][terraform.workspace == "dev" ? 0 : 1 ]
}



module "s3_bucket_dev" {

  # count      = terraform.workspace == "dev" ? 1 : 0
  # for_each   = terraform.workspace == "dev" ? toset(var.pull_requests) : 1
  for_each   = local.pull_requests
  
  source         = "./modules/s3-website-buckets"

  s3_redirect_name         = "rhresume-${terraform.workspace}-${each.key}.com"
  s3_web_name              = "www.rhresume-${terraform.workspace}-${each.key}.com"
  
}

/*
module "s3_bucket_prod" {
  count      = terraform.workspace == "prod" ? 1 : 0

  source         = "./modules/s3-website-buckets"

  
  s3_redirect_name         = "rhresume.com"
  s3_web_name              = "www.rhresume.com"
  s3_redirect_host_name    = "www.rhresume.com"
  origin_access_identity   = module.distributions_prod[0].origin_access_identity

}
*/



module "s3_bucket_config_dev" {

  source         = "./modules/s3-website-config"

  for_each = local.pull_requests

  s3_redirect_name         = module.s3_bucket_dev[each.key].s3_redirect_bucket_name
  s3_web_name              = module.s3_bucket_dev[each.key].s3_bucket_name

  # s3_redirect_host_name    = module.distributions_dev[each.key].distribution_domain
  s3_redirect_host_name    = data.aws_cloudfront_distribution.distribution_domain_dev[each.key].domain_name
  origin_access_identity   = module.distributions_access_dev[each.key].origin_access_identity

}

module "s3_objects_dev" {

  source         = "./modules/s3-objects"
  for_each       = module.s3_bucket_dev


}



module "distributions_invalidation_dev" {
  
  source    = "./modules/distributions-invalidation"
  for_each  = local.pull_requests

  index_html_etag = module.s3_objects_dev[each.key].index_html_etag
  counter_js_etag = module.s3_objects_dev[each.key].counter_js_etag
  style_css_etag =  module.s3_objects_dev[each.key].style_css_etag
  redirect_distribution_id = module.distributions_dev[each.key].redirect_distribution_id

}

module "distributions_access_dev" {

  source    = "./modules/distributions-access"
  for_each  = local.pull_requests

  s3_origin_id = module.s3_bucket_dev[each.key].s3_regional_dom_name

}

data "aws_cloudfront_distribution" "distribution_domain_dev" {

  for_each = module.distributions_dev
  id = module.distributions_dev[each.key].distribution_id

}

module "distributions_dev" {

  # count      = terraform.workspace == "dev" ? 1 : 0
  # for_each   = terraform.workspace == "dev" ? toset(var.pull_requests) : 1
  for_each   = local.pull_requests

  source         = "./modules/distributions"
  

  s3_dist_alias = null
  s3_redirect_dist_alias = null
  s3_redirect_origin_id = module.s3_bucket_dev[each.key].s3_redirect_regional_dom_name
  s3_redirect_website_endpoint = module.s3_bucket_config_dev[each.key].s3_redirect_website_endpoint
  s3_origin_id = module.s3_bucket_dev[each.key].s3_regional_dom_name
  acm_certificate_arn = null
  cloudfront_default_certificate = true
  ssl_support_method = null
  minimum_protocol_version = null


}

/*
module "distributions_prod" {
  count      = terraform.workspace == "prod" ? 1 : 0

  source         = "./modules/distributions"
  
  index_html_etag = module.s3_bucket_prod[0].index_html_etag
  counter_js_etag = module.s3_bucket_prod[0].counter_js_etag
  style_css_etag =  module.s3_bucket_prod[0].style_css_etag
  s3_dist_alias = ["www.rhresume.com"]
  s3_redirect_dist_alias = ["rhresume.com"]
  s3_redirect_origin_id = terraform.workspace == "prod" ? module.s3_bucket_prod[0].s3_redirect_regional_dom_name : 0
  s3_redirect_website_endpoint = module.s3_bucket_prod[0].s3_redirect_website_endpoint
  s3_origin_id = module.s3_bucket_prod[0].s3_regional_dom_name
  acm_certificate_arn = module.distributions_prod[0].acm_certificate_arn
  cloudfront_default_certificate = false
  ssl_support_method = "sni-only"
  minimum_protocol_version = "TLSv1.2_2021"

}
*/



### ONE OIDC ACTION ROLE PER ACCOUNT ###
########################################

module "actions_role" {
  count      = terraform.workspace == "dev" ? 1 : 0

  source     = "./modules/iam_resources/github_oidc" 
 
}

module "actions_role_prod" {
  count      = terraform.workspace == "prod" ? 1 : 0

  source     = "./modules/iam_resources/github_oidc" 
  providers = {
    aws = aws.prod
  }
 
}


module "actions_role_global" {
  count      = terraform.workspace == "global" ? 1 : 0

  source     = "./modules/iam_resources/github_oidc" 
  providers = {
    aws = aws.global
  }
 
}




/*
module "cross_account_role" {
  count      = terraform.workspace == "default" ? 1 : 0

  source         = "./modules/iam_resources/cross_account" 
  dev_account_id = "${data.aws_caller_identity.dev.account_id}"
  global_account_id = "${data.aws_caller_identity.global.account_id}"
  
}
*/


/*
module "actions_role_global" {
  count      = terraform.workspace == "global" ? 1 : 0

  source         = "./modules/iam_resources/assumable_role" 
  dev_account_id = "${data.aws_caller_identity.dev.account_id}"
  global_account_id = "${data.aws_caller_identity.global.account_id}"
  providers = {
    aws.global = aws.global
    aws.dev = aws.dev
  }

}
*/















