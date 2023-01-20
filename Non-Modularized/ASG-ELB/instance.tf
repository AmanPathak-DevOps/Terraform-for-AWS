# resource "aws_security_group" "SG" {
#   name   = "SG"
#   vpc_id = aws_vpc.vpc.id
#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }


resource "aws_instance" "EC2" {
  ami           = "ami-09d56f8956ab235b3"
  instance_type = "t2.micro"
  key_name      = "Aman-Pathak"
  subnet_id     = aws_subnet.public-subnet-1.id
  tags = {
    Name = "EC2"
  }
}

resource "aws_ami_from_instance" "AMI-Aman" {
  source_instance_id = aws_instance.EC2.id
  name               = "AMI-Aman"
}
