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

  // mesmo backend da aula do 01-remote-state, com a adição do novo parametro dynamodb_table
  backend "s3" {
    bucket         = "tf-state010438491289"
    key            = "06-workspaces/terraform.tfstate"
    region         = "us-east-1"
    profile        = "cael-terraform"
    dynamodb_table = "tflock-tf-state010438491289"
  }
}

locals {
  env = terraform.workspace == "default" ? "dev" : terraform.workspace
}

provider "aws" {
  region  = lookup(var.aws_region, local.env)
  profile = "cael-terraform"
}

resource "aws_instance" "web" {
  count = lookup(var.instance, local.env)["number"]

  ami           = lookup(var.instance, local.env)["ami"]
  instance_type = lookup(var.instance, local.env)["type"]

  tags = {
    Name = "Minha máquina web ${local.env}"
    Env  = local.env
  }
}

// {"ID":"0866898a-a156-25dc-ae26-220698bd0caf","Operation":"OperationTypeApply","Info":"","Who":"CATHO_ONLINE\\raphael.oliveira@N-CATHO-015217","Version":"1.12.1","Created":"2025-07-09T15:49:55.841067Z","Path":"tf-state010438491289/env:/prod/06-workspaces/terraform.tfstate"}
