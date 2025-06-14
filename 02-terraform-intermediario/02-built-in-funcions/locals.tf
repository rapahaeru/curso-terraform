locals {
  common_tags = {
    Owner   = "rapahaeru"
    Course  = "Terraform"
    Project = "Curso AWS com Terraform"
  }

  object_name = "arquivo-gerado-de-um-template"
  file_ext    = "zip"

  instance_number = lookup(var.instance_number, var.env)
}