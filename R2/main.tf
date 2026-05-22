provider "aws" {
  region = "us-east-1"
}

# Create IAM user
resource "aws_iam_user" "admin_user" {
  name = "terraform-admin-user"
}

# Attach AdministratorAccess policy
resource "aws_iam_user_policy_attachment" "admin_attach" {
  user       = aws_iam_user.admin_user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Create console login password
resource "aws_iam_user_login_profile" "admin_login" {
  user                    = aws_iam_user.admin_user.name
  password_reset_required = true
}

# Create access keys for CLI/API usage
resource "aws_iam_access_key" "admin_key" {
  user = aws_iam_user.admin_user.name
}

output "access_key_id" {
  value = aws_iam_access_key.admin_key.id
}

output "secret_access_key" {
  value     = aws_iam_access_key.admin_key.secret
  sensitive = true
}