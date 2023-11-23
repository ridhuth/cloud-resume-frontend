output "origin_access_identity" {
  value = aws_cloudfront_origin_access_identity.origin_access.iam_arn
  description = "A pre-generated ARN for use in S3 bucket policies (see below). Example: arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity E2QWRUHAPOMQZL"
}