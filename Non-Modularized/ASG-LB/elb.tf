resource "aws_eip" "eip1" {
  tags = {
    Name = "eip1"
  }
}

resource "aws_eip" "eip2" {
  tags = {
    Name = "eip2"
  }
}



resource "aws_lb" "nlb" {
  name               = "this"
  internal           = false
  load_balancer_type = "network"
  subnet_mapping {
    subnet_id     = aws_subnet.public-subnet-1.id
    allocation_id = aws_eip.eip1.id
  }

  subnet_mapping {
    subnet_id     = aws_subnet.public-subnet-2.id
    allocation_id = aws_eip.eip2.id
  }


  tags = {
    Name = "nlb"
  }
}


resource "aws_lb_target_group" "lb_tg" {
  name        = "http"
  vpc_id      = aws_vpc.vpc.id
  port        = 80
  protocol    = "TCP"
  target_type = "instance"

  health_check {
    enabled  = true
    interval = 30
    port     = 80
  }

  tags = {
    Name = "lb_tg"
  }
}

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_tg.id
  }
}




resource "aws_security_group" "custom-elb-sg" {
  name   = "custom-elb-sg"
  vpc_id = aws_vpc.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "custom-elb-sg"
  }
}


resource "aws_security_group" "custom-instance-sg" {
  vpc_id = aws_vpc.vpc.id
  name   = "custom-instance-sg"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.custom-elb-sg.id]
    cidr_blocks     = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.custom-elb-sg.id]
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
    Name = "custom-instance-sg"
  }
}