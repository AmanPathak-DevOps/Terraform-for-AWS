data "aws_ami" "ami" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


data "aws_subnet" "public-subnet" {
  tags = {
    Name = "Public-Networking"
  }
}

data "aws_security_group" "sg" {
  tags = {
    Name = "SecurityGroup-Networking"
  }
}