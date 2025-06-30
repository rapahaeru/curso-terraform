locals {
  files = {
    "file_01.txt" : "file_01 content",
    "file_02.txt" : "file_02 content",
  }
}

module "basic_module_ex" {
  source   = "./basic_module_ex"
  for_each = local.files

  filename = each.key
  content  = each.value
}


