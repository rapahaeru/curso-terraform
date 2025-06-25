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

}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile

  # Como já tenho meu profile criado, não é necessário utilizar as chaves de acesso abaixo
  # access_key = ""
  # secret_key = ""
}



// espécie de pull, aqui ele está puxando as informações de identificação da minha conta aws
data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "remote-state" {
  bucket = "tf-state${data.aws_caller_identity.current.account_id}"

  versioning {
    enabled = true
  }

  tags = {
    Name        = "rapahaeru remote state bucket"
    Description = "stores terraform remote states files"
    #Environment = var.enviroment
    Managedby = "Terraform"
    UpdatedBy = "2025-06-14"
    Owner     = "rapahaeru"
  }

}

output "remote_state_bucket" {
  value = aws_s3_bucket.remote-state.bucket
}

output "remote_state_arn" {
  value = aws_s3_bucket.remote-state.arn
}