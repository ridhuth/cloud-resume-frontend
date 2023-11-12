provider "aws" {
  alias  = "dev"
  profile = "dev"
  region = "us-east-1"
}

provider "aws" {
  alias  = "global"
  profile = "global"
  region = "us-east-1"
}

module "s3_bucket" {
  count      = terraform.workspace == "default" ? 1 : 0

  source         = "./modules/s3-website-buckets"

  
  s3_redirect_name         = "rhresume.com"
  s3_web_name              = "www.rhresume.com"
  s3_redirect_host_name    = "www.rhresume.com"
  origin_access_identity   = module.distributions[0].origin_access_identity

}


module "distributions" {
  count      = terraform.workspace == "default" ? 1 : 0

  source         = "./modules/distributions"
  
  # index_html_etag = terraform.workspace == "default" ? module.s3_bucket[0].index_html_etag : 0
  index_html_etag = module.s3_bucket[0].index_html_etag
  counter_js_etag = module.s3_bucket[0].counter_js_etag
  style_css_etag =  module.s3_bucket[0].style_css_etag
  s3_dist_alias = ["www.rhresume.com"]
  s3_redirect_dist_alias = ["rhresume.com"]
  s3_redirect_origin_id = terraform.workspace == "default" ? module.s3_bucket[0].s3_redirect_regional_dom_name : 0
  s3_redirect_website_endpoint = module.s3_bucket[0].s3_redirect_website_endpoint
  s3_origin_id = module.s3_bucket[0].s3_regional_dom_name
  acm_certificate_arn = module.distributions[0].acm_certificate_arn
  cloudfront_default_certificate = false
  minimum_protocol_version = "TLSv1.2_2021"

}

module "s3_bucket_dev" {
  count      = terraform.workspace == "dev" ? 1 : 0

  source         = "./modules/s3-website-buckets"

  s3_redirect_name         = "rhresume-${terraform.workspace}.com"
  s3_web_name              = "www.rhresume-${terraform.workspace}.com"
  s3_redirect_host_name    = "d7dqdmvrp7o46.cloudfront.net"
  origin_access_identity   = module.distributions_dev[0].origin_access_identity

}

module "distributions_dev" {
  count      = terraform.workspace == "dev" ? 1 : 0

  source         = "./modules/distributions"
  
  # index_html_etag = terraform.workspace == "default" ? module.s3_bucket[0].index_html_etag : 0
  index_html_etag = module.s3_bucket_dev[0].index_html_etag
  counter_js_etag = module.s3_bucket_dev[0].counter_js_etag
  style_css_etag =  module.s3_bucket_dev[0].style_css_etag
  s3_dist_alias = null
  s3_redirect_dist_alias = null
  s3_redirect_origin_id = module.s3_bucket_dev[0].s3_redirect_regional_dom_name
  s3_redirect_website_endpoint = module.s3_bucket_dev[0].s3_redirect_website_endpoint
  s3_origin_id = module.s3_bucket_dev[0].s3_regional_dom_name
  acm_certificate_arn = null
  cloudfront_default_certificate = true
  minimum_protocol_version = null

}

data "aws_caller_identity" "dev" {
  provider = aws.dev
}

data "aws_caller_identity" "global" {
  provider = aws.global
}


module "actions_role" {
  count      = terraform.workspace == "default" ? 1 : 0

  source         = "./modules/iam_resources/github_oidc" 
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



/*
module "actions_role_prod" {
  count      = terraform.workspace == "prod" ? 1 : 0

  source         = "./modules/iam_resources"
    
}
*/














