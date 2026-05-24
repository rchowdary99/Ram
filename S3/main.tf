# Bucket creation
# Tags
# Versioning
# Public access block
# Server-side encryption (AES256/KMS)
# Lifecycle rules
# Bucket policy (HTTPS only)
# Ownership controls
# Logging
# CORS
# Event notifications (optional)
# Intelligent tiering (optional)


############################
# S3 BUCKET
############################


# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 5.0"
#     }
#   }
# }

provider "aws" {
  region = "us-east-1"
}

############################
# S3 BUCKET
############################

resource "aws_s3_bucket" "my_bucket" {
  bucket = "ram-terraform-s3-bucket-1"

  tags = {
    Name        = "terraformbucket"
    Environment = "development"
    Owner       = "terraform"
  }
}

############################
# VERSIONING
############################

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.my_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

############################
# BLOCK PUBLIC ACCESS
############################

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.my_bucket.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

############################
# SERVER SIDE ENCRYPTION
############################

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.my_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

############################
# OBJECT OWNERSHIP
############################

resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.my_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

############################
# LIFECYCLE RULES
############################

# resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
#   bucket = aws_s3_bucket.my_bucket.id

#   rule {
#     id     = "cleanup-old-versions"
#     status = "Enabled"

#     noncurrent_version_expiration {
#       noncurrent_days = 30
#     }
#   }
# }

############################
# HTTPS ONLY POLICY
############################

resource "aws_s3_bucket_policy" "https_only" {
  bucket = aws_s3_bucket.my_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "DenyInsecureTransport"
        Effect = "Deny"

        Principal = "*"

        Action = "s3:*"

        Resource = [
          aws_s3_bucket.my_bucket.arn,
          "${aws_s3_bucket.my_bucket.arn}/*"
        ]

        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })
}


############################
# LOGGING BUCKET
############################

# resource "aws_s3_bucket" "log_bucket" {
#   bucket = "ram-terraform-s3-bucket-1"
# }

# resource "aws_s3_bucket_logging" "logging" {
#   bucket = aws_s3_bucket.my_bucket.id

#   target_bucket = aws_s3_bucket.log_bucket.id
#   target_prefix = "logs/"
# }

############################
# CORS
############################

# resource "aws_s3_bucket_cors_configuration" "cors" {
#   bucket = aws_s3_bucket.my_bucket.id

#   cors_rule {
#     allowed_headers = ["*"]

#     allowed_methods = [
#       "GET",
#       "PUT"
#     ]

#     allowed_origins = [
#       "*"
#     ]

#     expose_headers = [
#       "ETag"
#     ]

#     max_age_seconds = 3000
#   }
# }

############################
# OUTPUTS
############################

output "bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.my_bucket.arn
}