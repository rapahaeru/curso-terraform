terraform {
    required_version = "0.14.4"
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "5.99.1"
      }
    }
}

provider "aws" {
    region = "us-east-1"
    profile = "cael-terraform"
}

resource "aws_s3_bucket" "rapahaeru-test-bucket" {
  bucket = "rapahaeru-test-bucket-0005220"

  tags = {
    Name        = "rapahaeru bucket"
    Environment = "Dev"
    Managedby = "Terraform"

  }
}