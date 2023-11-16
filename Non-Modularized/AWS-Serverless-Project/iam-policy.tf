resource "aws_iam_role_policy" "lambda-policy" {
  name = var.policy-1
  role = aws_iam_role.iam_role_lambda.id


  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem",
          "dynamodb:GetItem",
          "dynamodb:Scan",
          "dynamodb:Query",
          "dynamodb:UpdateItem"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy" "amplify-policy" {
  name = var.policy-2
  role = aws_iam_role.iam_role_amplify.id


  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:CreateLogGroup",
          "logs:DescribeLogGroups",
          "codecommit:GitPull"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}