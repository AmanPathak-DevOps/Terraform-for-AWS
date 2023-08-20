# 3 Attach Role with created policy
# Policy content file in iam-policy.json file

resource "aws_iam_role_policy" "iam-policy" {
  name   = "SSM-S3-Policy-Permission"
  role   = aws_iam_role.iam-role.id
  policy = file("${path.module}/iam-policy.json")
}