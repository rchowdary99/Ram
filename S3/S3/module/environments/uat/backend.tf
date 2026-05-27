terraform {
  backend "s3" {
    bucket         = "ram-test-bkt"
    key            = "uat/s3-module/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true

    # Optional locking
    use_lockfile = true
  }
}