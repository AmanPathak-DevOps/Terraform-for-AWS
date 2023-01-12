

resource "aws_launch_configuration" "LC" {
  name            = "LC"
  image_id        = aws_ami_from_instance.AMI-Aman.id
  instance_type   = "t2.micro"
  key_name        = "Aman-Pathak"
  security_groups = [aws_security_group.custom-instance-sg.id]
  user_data       = <<-EOF
                #!/bin/bash
                apt update
                apt upgrade
                apt-get -y install net-tools nginx
                cd /var/www/html
                sudo wget https://www.tooplate.com/zip-templates/2106_soft_landing.zip
                sudo apt install unzip
                sudo unzip 2106_soft_landing.zip
                sudo rm -rf 2106_soft_landing.zip index.nginx-debian.html
                cd 2106_soft_landing/
                sudo mv index.html ../
                sudo mv css ../
                sudo mv fonts ../
                sudo mv images js ../
                sudo rm -rf 2106_soft_landing/

    EOF
  lifecycle {
    create_before_destroy = true
  }
}