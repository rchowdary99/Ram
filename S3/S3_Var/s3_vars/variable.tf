variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "bucket_name" {
  type = string
}

variable "bucket_tag_name" {
  type    = string
  default = "terraformbucket"
}

variable "environment" {
  type    = string
  default = "development"
}

variable "owner" {
  type    = string
  default = "terraform"
}

variable "versioning_status" {
  type    = string
  default = "Enabled"
}

variable "block_public_acls" {
  type    = bool
  default = true
}

variable "ignore_public_acls" {
  type    = bool
  default = true
}

variable "block_public_policy" {
  type    = bool
  default = true
}

variable "restrict_public_buckets" {
  type    = bool
  default = true
}