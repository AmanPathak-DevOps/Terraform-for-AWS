provider "aws" {
  region = "us-east-1"
}
resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "Aman-VPC"
  }
}

resource "aws_subnet" "subnet-1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "Subnet-1"
  }
}

resource "aws_subnet" "subnet-2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name = "Subnet-2"
  }
}

resource "aws_security_group" "Aman-SG" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }



  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_internet_gateway" "Aman-IG" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Aman-IG"
  }
}

resource "aws_route_table" "Aman-RT" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Aman-IG.id
  }
  tags = {
    Name = "Aman-RT"
  }
}

# Assocaiting Route Table Association 1

resource "aws_route_table_association" "RT-Association1" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.Aman-RT.id
}

# Association Route Table Association 2

resource "aws_route_table_association" "RT-Association2" {
  subnet_id      = aws_subnet.subnet-2.id
  route_table_id = aws_route_table.Aman-RT.id
}

resource "aws_instance" "EC2" {
  subnet_id       = aws_subnet.subnet-1.id
  ami             = "ami-04505e74c0741db8d"
  instance_type   = "t2.micro"
  key_name        = "Aman-Pathak"
  security_groups = [aws_security_group.Aman-SG.id]
  tags = {
    Name = "Non-AMI-EC2"
  }
}

resource "aws_ami_from_instance" "Aman-AMI" {
  name               = "Aman-AMI"
  source_instance_id = aws_instance.EC2.id
}

resource "aws_launch_configuration" "Aman-LC" {
  name            = "Aman-LC"
  image_id        = aws_ami_from_instance.Aman-AMI.id
  instance_type   = "t2.micro"
  key_name        = "Aman-Pathak"
  security_groups = [aws_security_group.Aman-SG.id]
}

resource "aws_autoscaling_group" "Aman-ASG" {
  name                      = "Aman-ASG"
  vpc_zone_identifier       = [aws_subnet.subnet-1.id]
  launch_configuration      = aws_launch_configuration.Aman-LC.id
  min_size                  = 1
  max_size                  = 3
  health_check_grace_period = 300
  health_check_type         = "EC2"
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "custom-ec2-instance"
    propagate_at_launch = true
  }
}


resource "aws_autoscaling_policy" "custom-cpu-policy" {
  name                   = "custom-cpu-policy"
  autoscaling_group_name = aws_autoscaling_group.Aman-ASG.id
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 60
  policy_type            = "SimpleScaling"
}


resource "aws_cloudwatch_metric_alarm" "custom-cpu-alarm" {
  alarm_name          = "custom-cpu-alarm"
  alarm_description   = "alarm when cpu usage increases"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = "20"

  dimensions = {
    "AutoScalingGroupName" : aws_autoscaling_group.Aman-ASG.name
  }
  actions_enabled = true

  alarm_actions = [aws_autoscaling_policy.custom-cpu-policy.arn]
}


resource "aws_autoscaling_policy" "custom-cpu-policy-scaledown" {
  name                   = "custom-cpu-policy-scaledown"
  autoscaling_group_name = aws_autoscaling_group.Aman-ASG.id
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown               = 60
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "custom-cpu-alarm-scaledown" {
  alarm_name          = "custom-cpu-alarm-scaledown"
  alarm_description   = "alarm when cpu usage decreases"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = "20"

  dimensions = {
    "AutScalingGroupName" : aws_autoscaling_group.Aman-ASG.name
  }
  actions_enabled = true

  alarm_actions = [aws_autoscaling_policy.custom-cpu-policy-scaledown.arn]
}