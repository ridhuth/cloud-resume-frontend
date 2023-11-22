resource "aws_s3_bucket_policy" "allow_access_from_cloudfront" {
  bucket = var.s3_redirect_name
  policy = "{\"Id\":\"PolicyForCloudFrontPrivateContent\",\"Statement\":[{\"Action\":\"s3:GetObject\",\"Effect\":\"Allow\",\"Principal\":{\"AWS\":\"${var.origin_access_identity}\"},\"Resource\":\"arn:aws:s3:::${var.s3_redirect_name}/*\",\"Sid\":\"1\"}],\"Version\":\"2008-10-17\"}"
}

resource "aws_s3_bucket_policy" "allow_access_from_cloudfront_s3_web" {
  bucket = var.s3_web_name
  policy = "{\"Id\":\"PolicyForCloudFrontPrivateContent\",\"Statement\":[{\"Action\":\"s3:GetObject\",\"Effect\":\"Allow\",\"Principal\":{\"AWS\":\"${var.origin_access_identity}\"},\"Resource\":\"arn:aws:s3:::${var.s3_web_name}/*\",\"Sid\":\"1\"}],\"Version\":\"2008-10-17\"}"
}

resource "aws_s3_bucket_website_configuration" "s3_redirect_domain" {
  bucket                = var.s3_redirect_name
  redirect_all_requests_to {
    host_name = var.s3_redirect_host_name
    protocol  = "https"
  }
}