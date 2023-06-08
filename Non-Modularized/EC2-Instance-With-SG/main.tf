provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = var.S3_NAME
    key            = "terraform/state.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}


# creating VPC
resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "Aman-VPC"
  }
}

# creating subnet
resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Aman-Subnet"
  }
}

# creating security group
resource "aws_security_group" "security-group" {
  vpc_id      = aws_vpc.vpc.id
  description = "Inbound-Rules"

  ingress {
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "Aman-SG"
  }

}
resource "aws_instance" "Aman-EC2" {
  ami             = "ami-04505e74c0741db8d"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.subnet.id
  security_groups = [aws_security_group.security-group.id]
  key_name        = var.PEMFILE

  tags = {
    Name = "Aman-EC2"
  }
}

variable "PEMFILE" {
  default   = "AmanPathak.pem"
  type      = string
  sensitive = true
}

variable "S3_NAME" {
  default = "artifact-bucket-4290"
  type = string
  sensitive = true
}