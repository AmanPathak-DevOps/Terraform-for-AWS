resource "aws_iam_role" "iam-role" {
  name               = var.role_name
  assume_role_policy = file("${path.module}/${var.role_policy_file}")
}