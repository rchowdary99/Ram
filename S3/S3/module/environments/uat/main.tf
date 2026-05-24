module "s3" {
  source = "../../module/s3"

  bucket_name = var.bucket_name
  bucket_tag  = var.bucket_tag
  environment = var.environment
}