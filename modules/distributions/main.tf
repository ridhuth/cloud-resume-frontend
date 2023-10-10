

resource "aws_acm_certificate" "cert" {
  certificate_authority_arn = null
  certificate_body          = null
  certificate_chain         = null
  domain_name               = "rhresume.com"
  early_renewal_duration    = null
  key_algorithm             = "RSA_2048"
  private_key               = null # sensitive
  subject_alternative_names = ["*.rhresume.com", "rhresume.com"]
  tags                      = {}
  tags_all                  = {}
  validation_method         = "DNS"
  options {
    certificate_transparency_logging_preference = "ENABLED"
  }
}


resource "aws_cloudfront_distribution" "s3_redirect_distribution" {
  aliases                         = ["rhresume.com"]
  comment                         = null
  continuous_deployment_policy_id = null
  default_root_object             = null
  enabled                         = true
  http_version                    = "http2"
  is_ipv6_enabled                 = true
  price_class                     = "PriceClass_100"
  retain_on_delete                = false
  staging                         = false
  tags                            = {}
  tags_all                        = {}
  wait_for_deployment             = true
  web_acl_id                      = null
  default_cache_behavior {
    allowed_methods            = ["GET", "HEAD"]
    cache_policy_id            = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    cached_methods             = ["GET", "HEAD"]
    compress                   = true
    default_ttl                = 0
    field_level_encryption_id  = null
    max_ttl                    = 0
    min_ttl                    = 0
    origin_request_policy_id   = null
    realtime_log_config_arn    = null
    response_headers_policy_id = null
    smooth_streaming           = false
    target_origin_id           = "rhresume.com.s3.us-east-1.amazonaws.com"
    trusted_key_groups         = []
    trusted_signers            = []
    viewer_protocol_policy     = "redirect-to-https"
  }
  origin {
    connection_attempts      = 3
    connection_timeout       = 10
    domain_name              = "rhresume.com.s3-website-us-east-1.amazonaws.com"
    origin_access_control_id = null
    origin_id                = "rhresume.com.s3.us-east-1.amazonaws.com"
    origin_path              = null
    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_keepalive_timeout = 5
      origin_protocol_policy   = "http-only"
      origin_read_timeout      = 30
      origin_ssl_protocols     = ["TLSv1.2"]
    }
  }
  restrictions {
    geo_restriction {
      locations        = []
      restriction_type = "none"
    }
  }
  viewer_certificate {
    acm_certificate_arn            = aws_acm_certificate.cert.arn
    cloudfront_default_certificate = false
    iam_certificate_id             = null
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }
}


resource "aws_cloudfront_origin_access_identity" "origin_access" {
  comment = "www.rhresume.com.s3.us-east-1.amazonaws.com"
}


resource "aws_cloudfront_distribution" "s3_distribution" {
  aliases                         = ["www.rhresume.com"]
  comment                         = null
  continuous_deployment_policy_id = null
  default_root_object             = "index.html"
  enabled                         = true
  http_version                    = "http2"
  is_ipv6_enabled                 = true
  price_class                     = "PriceClass_100"
  retain_on_delete                = false
  staging                         = false
  tags                            = {}
  tags_all                        = {}
  wait_for_deployment             = true
  web_acl_id                      = null
  default_cache_behavior {
    allowed_methods            = ["GET", "HEAD"]
    cache_policy_id            = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    cached_methods             = ["GET", "HEAD"]
    compress                   = true
    default_ttl                = 0
    field_level_encryption_id  = null
    max_ttl                    = 0
    min_ttl                    = 0
    origin_request_policy_id   = null
    realtime_log_config_arn    = null
    response_headers_policy_id = null
    smooth_streaming           = false
    target_origin_id           = "rhresume.com.s3.us-east-1.amazonaws.com"
    trusted_key_groups         = []
    trusted_signers            = []
    viewer_protocol_policy     = "redirect-to-https"
  }
  origin {
    connection_attempts      = 3
    connection_timeout       = 10
    domain_name              = "www.rhresume.com.s3.us-east-1.amazonaws.com"
    origin_access_control_id = null
    origin_id                = "rhresume.com.s3.us-east-1.amazonaws.com"
    origin_path              = null
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access.cloudfront_access_identity_path
    }
  }
  restrictions {
    geo_restriction {
      locations        = []
      restriction_type = "none"
    }
  }
  viewer_certificate {
    acm_certificate_arn            = aws_acm_certificate.cert.arn
    cloudfront_default_certificate = false
    iam_certificate_id             = null
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }
}



# Invalidate the CF cache when S3 website home page is updated
resource "null_resource" "invalidate_cf_cache" {
  provisioner "local-exec" {
    command = "aws cloudfront create-invalidation --distribution-id ${aws_cloudfront_distribution.s3_redirect_distribution.id} --paths '/*'"
  }

  triggers = {
    etag_changed = var.index_html_etag
  }

}

# Invalidate the CF cache when S3 website javascript is updated
resource "null_resource" "invalidate_cf_js_cache" {
  provisioner "local-exec" {
    command = "aws cloudfront create-invalidation --distribution-id ${aws_cloudfront_distribution.s3_redirect_distribution.id} --paths '/script/*'"
  }
  triggers = {
    etag_changed = var.counter_js_etag
  }
}

# Invalidate the CF cache when S3 website style is updated
resource "null_resource" "invalidate_cf_css_cache" {
  provisioner "local-exec" {
    command = "aws cloudfront create-invalidation --distribution-id ${aws_cloudfront_distribution.s3_redirect_distribution.id} --paths '/style/*'"
  }
  triggers = {
    etag_changed = var.style_css_etag
  }
}