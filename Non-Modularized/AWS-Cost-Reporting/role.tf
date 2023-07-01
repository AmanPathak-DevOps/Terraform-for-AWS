resource "aws_iam_role" "iam-role" {
  name               = "iam-role-lambda-AWS-Cost-Reporting-Lambda"
  assume_role_policy = file("${path.module}/role.json")
}