terraform {
  # required_version = "0.14.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.99.1"
    }
  }
}

resource "null_resource" "null" {
  triggers = {
    time = timestamp()
  }

  provisioner "local-exec" {
    command = "echo %FOO% %BAR% %BAZ% %TIME% >> env_vars.txt"

    environment = {
      FOO  = "bar"
      BAR  = 1
      BAZ  = "true"
      TIME = timestamp()
    }
  }

  provisioner "local-exec" {
    # command = "rm -rf folder-test && mkdir folder-test && cd folder-test && npm init -y && npm install @catho/quantum"
    command = "rmdir /s /q folder-test && mkdir folder-test && cd folder-test && npm init -y && npm install @catho/quantum"
  }
}
