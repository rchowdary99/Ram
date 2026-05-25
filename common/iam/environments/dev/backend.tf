terraform {

 backend "s3" {

   bucket = "ram-terraform-s3-bucket-1"

   key = "iam/dev.tfstate"

   region = "us-east-1"

 }

}