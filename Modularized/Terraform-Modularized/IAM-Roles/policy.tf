resource "aws_iam_role_policy" "iam-policy" {
  name   = var.policy_name
  role   = aws_iam_role.iam-role.id
  policy = file("${path.module}/${var.policy_file}")
}