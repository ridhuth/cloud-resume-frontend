terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}


provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias   = "dev"
  profile = "dev"
  region  = "us-east-1"
}

provider "aws" {
  alias   = "global"
  profile = "global"
  region  = "us-east-1"
}

provider "aws" {
  alias   = "prod"
  profile = "prod"
  region  = "us-east-1"
}