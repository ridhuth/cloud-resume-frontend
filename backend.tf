terraform {
  backend "s3" {
    bucket         = "rhresume-frontend-bucket-remote-state-global"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "rhresume_frontend_state_global"
    encrypt        = true
    profile        = "global"
  }
}




