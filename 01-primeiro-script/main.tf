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