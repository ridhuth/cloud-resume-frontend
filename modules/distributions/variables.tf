
variable "index_html_etag" {
  description="index_html_etag"
}

variable "counter_js_etag" {
  description="counter_js_etag"
}

variable "style_css_etag" {
  description="style_css_etag"
}

variable "s3_origin_id" {
  description = "Unique identifier for the origin"
  type = string
}

variable "s3_dist_alias" {
  description = "alternate domain names for this distribution."
  type = list
}

variable "s3_redirect_dist_alias" {
  description = "alternate domain names for this distribution."
  type = list
}

variable "s3_redirect_origin_id" {
  description = "Unique identifier for the origin"
  type = string
}

variable "s3_redirect_website_endpoint" {
  description = "s3 origin website endpoint"
  type =  string
}

variable "acm_certificate_arn" {
  description = "acm_certificate_arn"
  type = string
}

variable "cloudfront_default_certificate" {
  description = "Users to use HTTPS viewing with cloudfront domain"
  type = bool
}

variable "minimum_protocol_version" {
  description = "Minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections."
  type = string
}





