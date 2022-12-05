resource "aws_iam_role" "iam-role" {
  name               = "iam-role-lambda-api-gateway"
  assume_role_policy = file("${path.module}/iam-role.json")
}