provider "aws" {
  region = "us-east-1"
}



resource "aws_instance" "ec2" {
  ami           = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"
  tags = {
    name = "Aman-EC2"
  }
  key_name = "Aman-Pathak"
}