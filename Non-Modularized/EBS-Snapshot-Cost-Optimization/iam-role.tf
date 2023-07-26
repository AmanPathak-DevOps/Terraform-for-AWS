resource "aws_iam_role" "role-for-cost-optimization" {
  name               = "iam-role-${var.lambda-function-name}"
  assume_role_policy = file("${path.module}/iam-role.json")
}