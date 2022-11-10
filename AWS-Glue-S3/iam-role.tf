resource "aws_iam_role" "iam-role" {
  name               = "iam-role-for-glue"
  assume_role_policy = file("${path.module}/glue-role.json")
}