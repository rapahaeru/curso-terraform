locals {
  path     = var.path != null ? var.path : "${path.root}/files"
  content  = var.content
  filename = var.filename
}

resource "local_file" "this" {
  filename = "${local.path}/${local.filename}"
  content  = local.content
}
