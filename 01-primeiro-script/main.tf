provider "aws" {
    region = "us-east-1"
    profile = "cael-terraform"
    # access_key = ""
    # secret_key = ""
}

resource "aws_s3_bucket" "my-test-bucket" {
  bucket = "my-tf-test-bucket-00005220"
  acl = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
    managedby = "Terraform"
  }
}