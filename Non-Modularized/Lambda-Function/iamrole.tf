resource "aws_iam_role" "lambda-aman-role2" {
  name               = "lambda-aman-role2"
  assume_role_policy = file("${path.module}/lambda_role.json")
}
