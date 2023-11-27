resource "aws_s3_bucket" "rhresume_bucket" {
  bucket              = var.s3_redirect_name
  bucket_prefix       = null
  force_destroy       = null
  object_lock_enabled = false
  tags                = {}
  tags_all            = {}
}



resource "aws_s3_bucket_versioning" "rhresume_bucket_versioning" {
  # bucket                = var.s3_redirect_name
  bucket                = aws_s3_bucket.rhresume_bucket.id
  expected_bucket_owner = null
  mfa                   = null
  versioning_configuration {
    mfa_delete = null
    status     = "Disabled"
  }
}


resource "aws_s3_bucket_server_side_encryption_configuration" "rhresume_bucket_encryption" {
  bucket                = aws_s3_bucket.rhresume_bucket.id
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
  bucket                = aws_s3_bucket.wwwrhresume_bucket.id
  expected_bucket_owner = null
  mfa                   = null
  versioning_configuration {
    mfa_delete = null
    status     = "Disabled"
  }
}


resource "aws_s3_bucket_server_side_encryption_configuration" "wwwrhresume_bucket_encryption" {
  bucket                = aws_s3_bucket.wwwrhresume_bucket.id
  expected_bucket_owner = null
  rule {
    bucket_key_enabled = true
    apply_server_side_encryption_by_default {
      kms_master_key_id = null
      sse_algorithm     = "AES256"
    }
  }
}



