# Creating EC2 Instance 1

resource "aws_instance" "EC2-One" {
  ami             = "ami-03ededff12e34e59e"
  instance_type   = "t2.micro"
  key_name        = "AmanPathak"
  subnet_id       = aws_subnet.subnet1.id
  security_groups = [aws_security_group.security_group.id]
  user_data       = <<-EOF
                #!/bin/bash
                yum install httpd -y
                echo "Hey!!! I am $(hostname -f)" > /var/www/html/index.html
                service httpd start
                chkconfig httpd on
  EOF
  tags = {
    Name = "Aman-EC2-1"
  }

}

# Creating EC2 Instance 2

resource "aws_instance" "EC2-Two" {
  ami             = "ami-03ededff12e34e59e"
  instance_type   = "t2.micro"
  key_name        = "AmanPathak"
  subnet_id       = aws_subnet.subnet2.id
  security_groups = [aws_security_group.security_group.id]
  user_data       = <<-EOF
                #!/bin/bash
                yum install httpd -y
                echo "Hey!!! I am $(hostname -f)" > /var/www/html/index.html
                service httpd start
                chkconfig httpd on
  EOF

  tags = {
    Name = "Aman-EC2-2"
  }
}