

module "s3_bucket" {
  source         = "./modules/s3-website-buckets"
  # count      = terraform.workspace == "default" ? 1 : 0
  
  s3_redirect_name         = "rhresume.com"
  s3_web_name              = "www.rhresume.com"

}

module "s3_bucket_dev" {
  source         = "./modules/s3-website-buckets"
  count      = terraform.workspace == "dev" ? 1 : 0
  
  s3_redirect_name         = "rhresume.com-${terraform.workspace}"
  s3_web_name              = "www.rhresume.com-${terraform.workspace}"

}

module "distributions" {
  source         = "./modules/distributions"
  count      = terraform.workspace == "default" ? 1 : 0
  
  index_html_etag = module.s3_bucket.index_html_etag
  counter_js_etag = module.s3_bucket.counter_js_etag
  style_css_etag = module.s3_bucket.style_css_etag

}

module "actions_role" {
  source         = "./modules/iam_resources"
  count      = terraform.workspace == "default" ? 1 : 0
  

}