provider "aws" {
  region = "us-east-1"
}

module "s3" {
  source = "../../s3"

  bucket_name       = var.bucket_name
  environment       = var.environment
  versioning_enabled = var.versioning_enabled
  enable_tls_only    = var.enable_tls_only
}