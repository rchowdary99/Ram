module "iam_policy" {

  source = "../../modules/iam-policy"

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