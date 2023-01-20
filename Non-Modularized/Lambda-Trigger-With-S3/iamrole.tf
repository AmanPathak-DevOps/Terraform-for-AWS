resource "aws_iam_role" "lambda-aman-role3" {
  name               = "lambda-aman-role3"
  assume_role_policy = file("${path.module}/lambda_role.json")
}
