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
  region  = var.aws_region
  profile = var.aws_profile

  # Como já tenho meu profile criado, não é necessário utilizar as chaves de acesso abaixo
  # access_key = ""
  # secret_key = ""
}
