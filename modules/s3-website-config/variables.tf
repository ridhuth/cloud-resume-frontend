variable "s3_redirect_name" {
  description="s3 bucket name for redirect bucket"
  type = string
}

variable "s3_web_name" {
  description="s3 bucket name for resume asset bucket"
  type = string
}


variable "s3_redirect_host_name" {
  description="Redirect requests to another bucket or domain."
  type = string
}

variable "origin_access_identity" {
  description="origin access identity"
  type = string
}