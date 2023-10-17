

module "s3_bucket" {

  source         = "./modules/s3-website-buckets"
  s3_redirect_name         = "rhresume.com"
  s3_web_name              = "www.rhresume.com"

}

module "distributions" {

  source         = "./modules/distributions"
  index_html_etag = module.s3_bucket.index_html_etag
  counter_js_etag = module.s3_bucket.counter_js_etag
  style_css_etag = module.s3_bucket.style_css_etag

}

module "actions_role" {

  source         = "./modules/iam_resources"

}