resource "aws_iam_role" "iam-role" {
  name               = "role-for-ec2"
  assume_role_policy = file("${path.module}/iam-role.json")
}