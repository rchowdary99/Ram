resource "aws_s3_bucket" "this" {
  
  bucket = var.bucket_name
  #bucket = "${var.bucket_name}-${var.environment}"

  tags = {
    Environment = var.environment
    GitHubRepo  = "https://github.com/rchowdary99/Ram.git"
    GitHubPath  = "S3/S3/module"
    GitHubBranch = "main"
    Owner = "Ram"
    Email="rdanda99@gmail.com"
    Phone="73493680017"
    Fax="27339799"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.versioning_enabled ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}