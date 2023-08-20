# 6 Creating Launch Configuration for Web-Tier, Make sure to add your custom AMI or AWS Ubuntu AMI. I have used Ubuntu 22.04 AMI. So, do accordingly
resource "aws_launch_configuration" "Web-LC" {
  name          = "Web-LC"
  image_id      = "ami-0b8e413243acd6d7b"
  instance_type = "t2.micro"
  security_groups      = [aws_security_group.Web-SG.id]
  iam_instance_profile = aws_iam_instance_profile.test_profile.arn
  lifecycle {
    create_before_destroy = true
  }
}

# Creating Launch Configuration for App-Tier, Make sure to add your custom AMI or AWS Ubuntu AMI. I have used Ubuntu 22.04 AMI. So, do accordingly
resource "aws_launch_configuration" "App-LC" {
  name          = "App-LC"
  image_id      = "ami-0dd705465e0cd0516"
  instance_type = "t2.micro"
  security_groups      = [aws_security_group.App-SG.id]
  iam_instance_profile = aws_iam_instance_profile.test_profile.arn
  lifecycle {
    create_before_destroy = true
  }
}

