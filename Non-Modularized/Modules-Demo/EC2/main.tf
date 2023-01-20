terraform {
  required_version = ">= 0.12"
}
resource "aws_instance" "EC2" {
  ami           = var.ami
  instance_type = "t2.micro"
  key_name      = var.key
  subnet_id     = aws_subnet.subnet.id
  tags = {
    Name = "Aman-EC2"
  }
}
