module "iam_policy" {
  #source = "D:/Ram/Study/Devops/terraform_new/common/modules/iam_policy"
  source = "../../module/iam-policy"
  

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