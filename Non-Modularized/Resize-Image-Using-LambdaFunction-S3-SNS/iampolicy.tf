resource "aws_iam_role_policy" "iam-policy" {
  name   = "lambda-policy-Resize-Image"
  role   = aws_iam_role.lambda-role.id
  policy = file("${path.module}/lambda_policy.json")
}

