resource "aws_iam_role_policy" "iam-policy-aman2" {
  name   = "iam-policy-aman2"
  role   = aws_iam_role.lambda-aman-role3.id
  policy = file("${path.module}/lambda_policy.json")
}

