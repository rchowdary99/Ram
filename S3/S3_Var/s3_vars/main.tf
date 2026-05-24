# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 5.0"
#     }
#   }
# }

provider "aws" {
  region = var.aws_region
}

############################
# S3 BUCKET
############################

resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_tag_name
    Environment = var.environment
    Owner       = var.owner
  }
}

############################
# VERSIONING
############################

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.my_bucket.id

  versioning_configuration {
    status = var.versioning_status
  }
}

############################
# PUBLIC ACCESS BLOCK
############################

resource "aws_s3_bucket_public_access_block" "public_block" {
  bucket = aws_s3_bucket.my_bucket.id

  block_public_acls       = var.block_public_acls
  ignore_public_acls      = var.ignore_public_acls
  block_public_policy     = var.block_public_policy
  restrict_public_buckets = var.restrict_public_buckets
}