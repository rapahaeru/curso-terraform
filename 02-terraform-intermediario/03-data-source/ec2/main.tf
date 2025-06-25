terraform {
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

  backend "s3" {
    bucket  = "tf-state010438491289"
    key     = "dev/03-data-source/terraform.tfstate"
    region  = "us-east-1"
    profile = "cael-terraform"
  }

}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile

  # Como já tenho meu profile criado, não é necessário utilizar as chaves de acesso abaixo
  # access_key = ""
  # secret_key = ""
}
