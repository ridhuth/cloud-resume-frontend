resource "aws_s3_bucket" "rhresume_bucket" {
  bucket              = var.s3_redirect_name
  bucket_prefix       = null
  force_destroy       = null
  object_lock_enabled = false
  tags                = {}
  tags_all            = {}
}





resource "aws_s3_bucket_versioning" "rhresume_bucket_versioning" {
  bucket                = var.s3_redirect_name
  expected_bucket_owner = null
  mfa                   = null
  versioning_configuration {
    mfa_delete = null
    status     = "Disabled"
  }
}


resource "aws_s3_bucket_server_side_encryption_configuration" "rhresume_bucket_encryption" {
  bucket                = var.s3_redirect_name
  expected_bucket_owner = null
  rule {
    bucket_key_enabled = true
    apply_server_side_encryption_by_default {
      kms_master_key_id = null
      sse_algorithm     = "AES256"
    }
  }
}


resource "aws_s3_bucket" "wwwrhresume_bucket" {
  bucket              = var.s3_web_name
  bucket_prefix       = null
  force_destroy       = null
  object_lock_enabled = false
  tags                = {}
  tags_all            = {}
}



resource "aws_s3_bucket_versioning" "wwwrhresume_bucket_versioning" {
  bucket                = var.s3_web_name
  expected_bucket_owner = null
  mfa                   = null
  versioning_configuration {
    mfa_delete = null
    status     = "Disabled"
  }
}


resource "aws_s3_bucket_server_side_encryption_configuration" "wwwrhresume_bucket_encryption" {
  bucket                = var.s3_web_name
  expected_bucket_owner = null
  rule {
    bucket_key_enabled = true
    apply_server_side_encryption_by_default {
      kms_master_key_id = null
      sse_algorithm     = "AES256"
    }
  }
}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.wwwrhresume_bucket.id
  key    = "index.html"
  source = "index.html"
  content_type = "text/html"


  etag = filemd5("index.html")
}

resource "aws_s3_object" "visitor_counter_object" {
  bucket = aws_s3_bucket.wwwrhresume_bucket.id
  key    = "script/visitorCounter.js"
  source = "script/visitorCounter.js"
  content_type = "text/javascript"
  


  etag = filemd5("script/visitorCounter.js")
}

resource "aws_s3_object" "style_object" {
  bucket = aws_s3_bucket.wwwrhresume_bucket.id
  key    = "style/style.css"
  source = "style/style.css"
  content_type = "text/css"


  etag = filemd5("style/style.css")
}

