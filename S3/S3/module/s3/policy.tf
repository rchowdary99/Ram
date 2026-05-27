resource "aws_s3_bucket_policy" "tls_policy" {

  bucket = aws_s3_bucket.this.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [

      # Deny HTTP access
      {
        Sid = "DenyInsecureTransport"

        Effect = "Deny"

        Principal = "*"

        Action = "s3:*"

        Resource = [
          aws_s3_bucket.this.arn,
          "${aws_s3_bucket.this.arn}/*"
        ]

        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      },

      # Additional IAM access
      {
        Sid = "AllowRead"

        Effect = "Allow"

        Principal = {
          AWS = "arn:aws:iam::702252493868:user/ram-terraform"
        }

        Action = [
          "s3:GetObject"
        ]

        Resource = [
          "${aws_s3_bucket.this.arn}/*"
        ]
      }

    ]
  })
}