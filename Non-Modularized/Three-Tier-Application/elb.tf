# 4 Creating Application Load Balancers, Target Group and Listeners for Web Tier and Application Tier


# Creating ALB for Web Tier
resource "aws_lb" "web-elb" {
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.public-subnet1.id, aws_subnet.public-subnet2.id]
  security_groups    = [aws_security_group.web-elb-sg.id]
  ip_address_type    = "ipv4"
  tags = {
    Name = "Web-elb"
  }
}

# Creating Target Group for Web-Tier 
resource "aws_lb_target_group" "web-tg" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  tags = {
    Name = "Web-TG"
  }
}


# Creating ALB listener with port 80 and attaching it to Web-Tier Target Group
resource "aws_lb_listener" "web-alb-listener" {
  load_balancer_arn = aws_lb.web-elb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web-tg.arn
  }
}

# Creating Web-Tier ALB Security Group with All traffic for Inbound and Outbound
resource "aws_security_group" "web-elb-sg" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-elb-sg"
  }
}


# Creating ALB for App Tier
resource "aws_lb" "app-elb" {
  internal           = true
  load_balancer_type = "application"
  subnets            = [aws_subnet.private-subnet1.id, aws_subnet.private-subnet2.id]
  security_groups    = [aws_security_group.app-elb-sg.id]
  ip_address_type    = "ipv4"
  tags = {
    Name = "App-elb"
  }
}

# Creating Target Group for App-Tier
resource "aws_lb_target_group" "app-tg" {
  health_check {
    interval            = 10
    path                = "/health"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  port     = 4000
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  tags = {
    Name = "App-TG"
  }
}

# Creating ALB listener with port 80 and attaching it to App-Tier Target Group
resource "aws_lb_listener" "app-elb-listener" {
  load_balancer_arn = aws_lb.app-elb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app-tg.arn
  }
}


# Creating App-Tier ALB Security Group with Web-Security-Group traffic only for Inbound
resource "aws_security_group" "app-elb-sg" {
  vpc_id = aws_vpc.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "TCP"
    security_groups = [aws_security_group.Web-SG.id]
  }

  tags = {
    Name = "app-elb-sg"
  }
}

