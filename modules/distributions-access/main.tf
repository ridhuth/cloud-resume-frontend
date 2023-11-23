resource "aws_cloudfront_origin_access_identity" "origin_access" {
  comment = var.s3_origin_id
}