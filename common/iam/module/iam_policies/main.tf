resource "aws_iam_policy" "env_policy" {
  name        = "${var.project}-${var.environment}-policy"
  description = "IAM policy for ${var.environment}"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"

        Action = var.actions

        Resource = var.resources
      }
    ]
  })

  tags = {
    Environment = var.environment
    Project     = var.project
  }
}