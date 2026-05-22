provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "R1" {
  name = "danda"
   tags = var.common_tags
  }
# S3 Policy
resource "aws_iam_user_policy" "inline_policy" {
  name = "user-inline-policy-s3"
  user = aws_iam_user.R1.name

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "s3:ListBucket",
          "s3:GetObject"
        ]

        Resource = [
          "arn:aws:s3:::my-bucket",
          "arn:aws:s3:::my-bucket/*"
        ]
      }
    ]
  })
}
#Ec2 Policy
resource "aws_iam_user_policy" "inline_policy_1" {
  name = "user-inline-policy-ec2"
  user = aws_iam_user.R1.name

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "ec2:DescribeInstances"
        ]

        Resource = "*"
      }
    ]
  })
}

# terraform code update