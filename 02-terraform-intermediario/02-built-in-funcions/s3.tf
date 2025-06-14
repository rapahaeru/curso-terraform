resource "random_pet" "bucket" {
  length = 5
}

resource "aws_s3_bucket" "this" {
  bucket = "${random_pet.bucket.id}-${var.env}"

  tags = local.common_tags

}

resource "aws_s3_object" "this" {
  bucket = aws_s3_bucket.this.bucket
  key    = "${uuid()}.${local.file_ext}" // nome do arquivo que será criado no bucket

  source       = data.archive_file.json.output_path // busca o arquivo físico exportado no data
  etag         = filemd5(data.archive_file.json.output_path)
  content_type = "application/zip"

  tags = local.common_tags
}