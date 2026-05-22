$policies = aws iam list-policies --scope Local `
    --query "Policies[*].[PolicyName,Arn]" `
    --output text

foreach ($line in $policies) {
    $parts = $line -split "\s+"

    $name = $parts[0].Replace("-", "_")
    $arn  = $parts[1]

    Add-Content main.tf @"

resource "aws_iam_policy" "$name" {
}
"@

    terraform import aws_iam_policy.$name $arn
}