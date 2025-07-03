output "filename_echo_list" {
  description = "itera e exibe cada arquivo"
  value       = [for m in module.create_and_upload : m.filename_echo]
}

output "all" {
  value = "finalizado"
}

# output "debug_content" {
#   value = module.basic_module_ex.debug_content
# }
