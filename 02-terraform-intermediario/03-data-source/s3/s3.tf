resource "random_pet" "bucket" {
  length = 5
}

resource "aws_s3_bucket" "this" {
  bucket = "my-bucket-${random_pet.bucket.id}"
}

resource "aws_s3_object" "this" {
  bucket       = aws_s3_bucket.this.bucket
  key          = "instances/instances-${local.instance.ami}.json"
  source       = "outputs.json"
  etag         = filemd5("outputs.json")
  content_type = "application/json"
}