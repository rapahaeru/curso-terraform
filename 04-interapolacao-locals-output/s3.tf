resource "aws_s3_bucket" "this" {
  bucket = "${random_pet.bucket.id}-${var.enviroment}"

  tags = local.common_tags
}

resource "aws_s3_object" "this" {
  bucket = aws_s3_bucket.this.bucket
  key    = "config/${local.filename}"
  source = local.filename
  etag   = filemd5(local.filename)
}