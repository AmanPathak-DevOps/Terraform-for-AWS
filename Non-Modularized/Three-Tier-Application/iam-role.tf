# 2 Create IAM Role for EC2 through SSM Manager
# Role file content in iam-role.json file

resource "aws_iam_role" "iam-role" {
  name               = "EC2-SSM-S3-Permissions"
  assume_role_policy = file("${path.module}/iam-role.json")
}

resource "aws_iam_instance_profile" "test_profile" {
  name = "test_profile"
  role = aws_iam_role.iam-role.name
}   