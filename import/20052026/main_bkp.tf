resource "aws_iam_policy" "imported_policy" {
    arn              = "arn:aws:iam::702252493868:policy/IAM_Users_Create"
    attachment_count = 2
    description      = "This role is cretaed for creating, listing and deleting the IAM users."
    id               = "arn:aws:iam::702252493868:policy/IAM_Users_Create"
    name             = "IAM_Users_Create"
    name_prefix      = null
    path             = "/"
    policy           = jsonencode(
        {
            Statement = [
                {
                    Action   = [
                        "iam:CreateUser",
                        "iam:TagUser",
                        "iam:ListGroupsForUser",
                        "iam:CreateAccessKey",
                        "iam:CreateLoginProfile",
                        "iam:GetLoginProfile",
                        "iam:ListAccessKeys",
                        "iam:ListAttachedUserPolicies",
                        "iam:GetLoginProfile",
                        "iam:PutUserPolicy",
                        "iam:GetUserPolicy",
                        "iam:DeleteUserPolicy",
                        "iam:AttachUserPolicy",
                        "iam:GetUser",
                        "iam:ListUsers",
                        "iam:DeleteUser",
                        "iam:UpdateUser",
                    ]
                    Effect   = "Allow"
                    Resource = "*"
                    Sid      = "Statement1"
                },
            ]
            Version   = "2012-10-17"
        }
    )
    policy_id        = "ANPA2HAMCVQWMEUH7HRDN"
    tags             = {}
    tags_all         = {}
}