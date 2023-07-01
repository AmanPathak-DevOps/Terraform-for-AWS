resource "aws_iam_role_policy" "iam-policy" {
  name   = "AWS-Lambda-Role-Policy-SES-CostExplorer"
  role   = aws_iam_role.iam-role.id
  policy = file("${path.module}/policy.json")
}