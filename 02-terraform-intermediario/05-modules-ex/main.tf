terraform {
  # required_version = "0.14.4"
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


locals {
  file_contents = {
    "file_01.txt" : "file_01 content",
    "file_02.txt" : "file_02 content",
  }
}

module "basic_module_ex" {
  source   = "./basic_module_ex"
  for_each = local.file_contents

  filename = each.key
  content  = each.value
}


