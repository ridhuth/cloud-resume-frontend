

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

module "actions_role" {
  count      = terraform.workspace == "default" ? 1 : 0

  source         = "./modules/iam_resources"
    
}








