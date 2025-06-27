terraform {
  #   required_version = "0.14.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.99.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

resource "random_pet" "this" {
  length = 5
}

module "bucket" {
  source = "./s3_module"
  name   = random_pet.this.id

  versioning = {
    enabled = true
  }
}

resource "random_pet" "website" {
  length = 5
}

module "website" {
  source = "./s3_module"

  name  = random_pet.website.id
  files = "${path.root}/website"

  website = {
    index_document = "index.html"
    error_document = "error.html"
  }
}
