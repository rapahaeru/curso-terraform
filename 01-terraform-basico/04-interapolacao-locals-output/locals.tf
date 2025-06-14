locals {
  common_tags = {
    Name        = "rapahaeru test bucket"
    Environment = var.enviroment
    Managedby   = "Terraform"
    updatedBy   = "2025-06-07"
    owner       = "Raphael"
  }

  filename = "ips.json"

}