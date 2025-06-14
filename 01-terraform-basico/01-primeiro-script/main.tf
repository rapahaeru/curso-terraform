terraform {
  # required_version = "0.14.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.99.1"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "cael-terraform"

  # Como já tenho meu profile criado, não é necessário utilizar as chaves de acesso abaixo
  # access_key = ""
  # secret_key = ""
}

resource "aws_s3_bucket" "rapahaeru-test-bucket" {
  bucket = "rapahaeru-test-bucket-0005220"

  tags = {
    Name        = "rapahaeru test bucket"
    Environment = "Dev"
    Managedby   = "Terraform"
    updatedBy   = "2025-06/07"

  }
}