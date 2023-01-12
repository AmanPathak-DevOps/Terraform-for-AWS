resource "aws_iam_role_policy" "iam-policy-aman" {
  name   = "iam-policy-aman"
  role   = aws_iam_role.lambda-aman-role2.id
  policy = file("${path.module}/lambda_policy.json")
}