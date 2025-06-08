resource "aws_s3_bucket" "rapahaeru-test-bucket" {
  bucket = "${random_pet.bucket.id}-${var.enviroment}"

  tags = {
    Name        = "rapahaeru test bucket"
    Environment = var.enviroment
    Managedby   = "Terraform"
    updatedBy   = "2025-06-07"
    owner = "Raphael"
  }
}