provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ec2" {
  ami           = "ami-007855ac798b5175e"
  instance_type = "t2.micro"
  ebs_optimized = true
  monitoring = true
  root_block_device {
    encrypted     = true
  }
  metadata_options {
        http_endpoint = "enabled"
        http_tokens   = "required"
  }
  iam_instance_profile = "EC2InstanceRole"
  tags = {
    name = "Aman-EC2"
  }
  key_name = "AmanPathak"
}