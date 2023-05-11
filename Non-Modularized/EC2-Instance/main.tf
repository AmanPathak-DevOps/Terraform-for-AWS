provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ec2" {
  ami           = "ami-007855ac798b5175e"
  instance_type = "t2.micro"
  tags = {
    name = "Aman-EC2"
  }
  key_name = "AmanPathak"
}