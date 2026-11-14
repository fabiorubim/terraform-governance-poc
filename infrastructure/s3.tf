provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "poc" {
  bucket = "terraform-governance-poc-667166076610"

  tags = {
    Name        = "terraform-governance-poc"
    Environment = "poc"
    ManagedBy   = "terraform"
  }
}

resource "aws_s3_bucket_public_access_block" "poc" {
  bucket = aws_s3_bucket.poc.id

  block_public_acls       = false
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "poc" {
  bucket = aws_s3_bucket.poc.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}