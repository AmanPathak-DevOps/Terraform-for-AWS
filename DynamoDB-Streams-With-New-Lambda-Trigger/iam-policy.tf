resource "aws_iam_role_policy" "iam-policy" {
  name   = "iam-policy-lambdad"
  role   = aws_iam_role.iam-role.id
  policy = file("${path.module}/iam-policy.json")
}