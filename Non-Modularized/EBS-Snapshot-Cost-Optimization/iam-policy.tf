resource "aws_iam_role_policy" "policy-for-cost-optimization" {
  name   = "iam-policy-${var.lambda-function-name}"
  role   = aws_iam_role.role-for-cost-optimization.id
  policy = file("${path.module}/iam-policy.json")
}