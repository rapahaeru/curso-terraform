output "filename_echo_list" {
  description = "itera e exibe cada arquivo"
  value       = [for m in module.basic_module_ex : m.filename_echo]
}

output "all" {
  value = "finalizado"
}
