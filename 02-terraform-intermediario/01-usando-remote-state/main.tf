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

  backend "s3" {
    bucket  = "tf-state010438491289"
    key     = "dev/01-usando-remote-state/terraform.tfstate"
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

resource "aws_instance" "this" {
  ami           = "ami-09e6f87a47903347c"
  instance_type = "t3.micro"

  tags = {
    name  = "Ec2-rapahaeru-terraform"
    Env   = "dev"
    Owner = "rapahaeru"
  }
}