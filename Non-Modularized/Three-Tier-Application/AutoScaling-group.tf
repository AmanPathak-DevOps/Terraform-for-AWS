# 7 Creating AutoScaling Group for Web Tier 

resource "aws_autoscaling_group" "Web-ASG" {
  vpc_zone_identifier  = [aws_subnet.public-subnet1.id, aws_subnet.public-subnet2.id]
  launch_configuration = aws_launch_configuration.Web-LC.id
  min_size             = 2
  max_size             = 4
  health_check_type    = "EC2"
  target_group_arns    = [aws_lb_target_group.web-tg.arn]
  force_delete         = true
  tag {
    key                 = "Name"
    value               = "Web-ASG"
    propagate_at_launch = true
  }

}


resource "aws_autoscaling_policy" "web-custom-cpu-policy" {
  name                   = "custom-cpu-policy"
  autoscaling_group_name = aws_autoscaling_group.Web-ASG.id
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 60
  policy_type            = "SimpleScaling"
}


resource "aws_cloudwatch_metric_alarm" "web-custom-cpu-alarm" {
  alarm_name          = "custom-cpu-alarm"
  alarm_description   = "alarm when cpu usage increases"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = "70"

  dimensions = {
    "AutoScalingGroupName" : aws_autoscaling_group.Web-ASG.name
  }
  actions_enabled = true

  alarm_actions = [aws_autoscaling_policy.web-custom-cpu-policy.arn]
}


resource "aws_autoscaling_policy" "web-custom-cpu-policy-scaledown" {
  name                   = "custom-cpu-policy-scaledown"
  autoscaling_group_name = aws_autoscaling_group.Web-ASG.id
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown               = 60
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "web-custom-cpu-alarm-scaledown" {
  alarm_name          = "custom-cpu-alarm-scaledown"
  alarm_description   = "alarm when cpu usage decreases"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = "50"

  dimensions = {
    "AutoScalingGroupName" : aws_autoscaling_group.Web-ASG.name
  }
  actions_enabled = true

  alarm_actions = [aws_autoscaling_policy.web-custom-cpu-policy-scaledown.arn]
}



# Creating AutoScaling Group for Application Tier 
resource "aws_autoscaling_group" "App-ASG" {
  vpc_zone_identifier  = [aws_subnet.private-subnet1.id, aws_subnet.private-subnet2.id]
  launch_configuration = aws_launch_configuration.App-LC.id
  min_size             = 2
  max_size             = 4
  health_check_type    = "EC2"
  target_group_arns    = [aws_lb_target_group.app-tg.arn]
  force_delete         = true
  tag {
    key                 = "Name"
    value               = "App-ASG"
    propagate_at_launch = true
  }

}


resource "aws_autoscaling_policy" "app-custom-cpu-policy" {
  name                   = "custom-cpu-policy"
  autoscaling_group_name = aws_autoscaling_group.App-ASG.id
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 60
  policy_type            = "SimpleScaling"
}


resource "aws_cloudwatch_metric_alarm" "app-custom-cpu-alarm" {
  alarm_name          = "custom-cpu-alarm"
  alarm_description   = "alarm when cpu usage increases"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = "70"

  dimensions = {
    "AutoScalingGroupName" : aws_autoscaling_group.App-ASG.name
  }
  actions_enabled = true

  alarm_actions = [aws_autoscaling_policy.app-custom-cpu-policy.arn]
}


resource "aws_autoscaling_policy" "app-custom-cpu-policy-scaledown" {
  name                   = "custom-cpu-policy-scaledown"
  autoscaling_group_name = aws_autoscaling_group.App-ASG.id
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown               = 60
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "app-custom-cpu-alarm-scaledown" {
  alarm_name          = "custom-cpu-alarm-scaledown"
  alarm_description   = "alarm when cpu usage decreases"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = "50"

  dimensions = {
    "AutoScalingGroupName" : aws_autoscaling_group.App-ASG.name
  }
  actions_enabled = true

  alarm_actions = [aws_autoscaling_policy.app-custom-cpu-policy-scaledown.arn]
}

