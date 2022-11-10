resource "aws_iam_role_policy" "iam-policy" {
  name   = "iam-policy-glue"
  role   = aws_iam_role.iam-role.id
  policy = file("${path.module}/glue-policy.json")
}