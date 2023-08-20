# 5 Creating Security Group for Web Instances Tier With your IP(test purpose) and only access to Web-Tier ALB
resource "aws_security_group" "Web-SG" {
  vpc_id      = aws_vpc.vpc.id
  description = "Protocol Type HTTP"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["115.110.237.74/32"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.web-elb-sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Web-SG"
  }
}

# Creating Security Group for App Instances Tier With your IP(test purpose) and only access to App-Tier ALB
resource "aws_security_group" "App-SG" {
  vpc_id      = aws_vpc.vpc.id
  description = "Protocol Type HTTP"

  ingress {
    from_port       = 4000
    to_port         = 4000
    protocol        = "tcp"
    security_groups = [aws_security_group.app-elb-sg.id]
  }

  ingress {
    from_port   = 4000
    to_port     = 4000
    protocol    = "TCP"
    cidr_blocks = ["115.110.237.74/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "App-SG"
  }
}
# Creating Security Group for RDS Instances Tier With  only access to App-Tier ALB
resource "aws_security_group" "Database-SG" {
  vpc_id      = aws_vpc.vpc.id
  description = "Protocol Type MySQL/Aurora"

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.App-SG.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Database-SG"
  }
}