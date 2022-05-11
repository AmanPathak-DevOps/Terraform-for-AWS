resource "aws_instance" "EC2" {
  ami               = "ami-09d56f8956ab235b3"
  instance_type     = "t2.micro"
  key_name          = "Aman-Pathak"
  subnet_id         = aws_subnet.Public-Subnet1.id
  security_groups   = [aws_security_group.SG.id]
  user_data         = <<-EOF
                #!/bin/bash
                apt update
                apt upgrade
                apt-get -y install net-tools nginx
                cd /var/www/html
                wget https://www.tooplate.com/zip-templates/2106_soft_landing.zip
                apt install unzip
                unzip 2106_soft_landing.zip
                rm -rf 2106_soft_landing.zip index.nginx-debian.html
                cd 2106_soft_landing/
                mv index.html css fonts images js ../
                rm -rf 2106_soft_landing/
    EOF
  availability_zone = "us-east-1a"
  tags = {
    Name = "EC2"
  }
}