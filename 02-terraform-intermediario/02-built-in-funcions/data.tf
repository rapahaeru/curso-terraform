data "template_file" "json" {
  template = file("template.json.tpl") // vai ler esse arquivo

  // e inserir dinamicamente esses valores nas variáveis presentes no template importado
  vars = {
    age    = 33
    eye    = "Brown"
    name   = "Cleber"
    gender = "Male"
  }
}

// pega o conteúdo do arquivo que for passado e converte para extensão que quiser, no caso aqui vamos passar para um zip
// ele vai pegar o conteúdo do template e exportar em um novo arquivo (zip)
// esse arquivo será utilizado para subir como exemplo no bucket S3
data "archive_file" "json" {
  type        = local.file_ext
  output_path = "${path.module}/files/${local.object_name}.${local.file_ext}"

  source {
    content  = data.template_file.json.rendered
    filename = "${local.object_name}.json"
  }
}