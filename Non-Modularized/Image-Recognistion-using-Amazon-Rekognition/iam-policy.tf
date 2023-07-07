resource "aws_iam_role_policy" "policy-for-image-rekognition" {
  name   = "iam-policy-${var.lambda-function-name}"
  role   = aws_iam_role.role-for-image-rekognition.id
  policy = file("${path.module}/iam-policy.json")
}