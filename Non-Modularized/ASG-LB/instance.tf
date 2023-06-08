resource "aws_instance" "EC2" {
  ami           = "ami-09d56f8956ab235b3"
  instance_type = "t2.micro"
  key_name      = "AmanPathak"
  subnet_id     = aws_subnet.public-subnet-1.id
  tags = {
    Name = "EC2"
  }
}

resource "aws_ami_from_instance" "AMI-Aman" {
  source_instance_id = aws_instance.EC2.id
  name               = "AMI-Aman"
}
