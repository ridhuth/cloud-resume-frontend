terraform {
  backend "s3" {
    bucket         = "rhresume-frontend-bucket-remote-state"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "rhresume_frontend_state"
    encrypt        = true
  }
}