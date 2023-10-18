
variable "index_html_etag" {
  description="index_html_etag"
}

variable "counter_js_etag" {
  description="counter_js_etag"
}

variable "style_css_etag" {
  description="style_css_etag"
}

variable "s3_redirect_dist_alias" {
  description = "alternate domain names for this distribution."
  type = list
}

variable "s3_redirect_origin_id" {
  description = "Unique identifier for the origin"
  type = string
}



