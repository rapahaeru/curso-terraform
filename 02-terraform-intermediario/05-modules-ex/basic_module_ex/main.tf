locals {
  path = var.path != null ? var.path : "${path.root}/files"
  # files    = { for file in fileset(local.path, "**") : file => file }
  content  = var.content
  filename = var.filename
}


resource "local_file" "this" {
  # for_each = { for file in fileset(local.path, "**") : file => file }
  filename = "${local.path}/${local.filename}"
  content  = local.content
}

resource "random_pet" "random" {
  length = 2
}

resource "aws_s3_bucket" "this" {
  bucket = random_pet.random.id
  tags = {
    "Name" : "rapahaeu"
    "Created" : "2025-06-30"
  }
}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.this.bucket

  # for_each = local.files

  key    = local.filename
  source = "${local.path}/${local.filename}"

  depends_on = [local_file.this]
}
