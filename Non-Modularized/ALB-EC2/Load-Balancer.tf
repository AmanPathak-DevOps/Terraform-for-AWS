# Creating Load Balancer 

resource "aws_lb" "Load-Balancer" {
  name               = "Load-Balancer"
  internal           = false
  security_groups    = [aws_security_group.security_group.id]
  subnets            = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
  load_balancer_type = "application"
  ip_address_type    = "ipv4"
}