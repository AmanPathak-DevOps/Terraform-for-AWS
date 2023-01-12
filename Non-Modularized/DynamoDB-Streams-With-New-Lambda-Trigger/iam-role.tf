resource "aws_iam_role" "iam-role" {
  name               = "iam-role-lambdad"
  assume_role_policy = file("${path.module}/iam-role.json")
}