module "dev_iam_policy" {
  source      = "../../module/iam_policies"
  project     = "myapp"
  environment = "dev"

  actions = [
    "s3:GetObject",
    "s3:ListBucket"
  ]

  resources = [
    "arn:aws:s3:::myapp-dev",
    "arn:aws:s3:::myapp-dev/*"
  ]
}

module "uat_iam_policy" {
  source      = "./modules/iam-policy"
  project     = "myapp"
  environment = "uat"

  actions = [
    "s3:GetObject",
    "s3:PutObject",
    "s3:ListBucket"
  ]

  resources = [
    "arn:aws:s3:::myapp-uat",
    "arn:aws:s3:::myapp-uat/*"
  ]
}

module "prod_iam_policy" {
  source      = "./modules/iam-policy"
  project     = "myapp"
  environment = "prod"

  actions = [
    "s3:*"
  ]

  resources = [
    "arn:aws:s3:::myapp-prod",
    "arn:aws:s3:::myapp-prod/*"
  ]
}