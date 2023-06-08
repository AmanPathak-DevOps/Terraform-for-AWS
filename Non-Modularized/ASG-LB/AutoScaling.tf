resource "aws_autoscaling_group" "Aman-ASG" {
  name                 = "Aman-ASG"
  vpc_zone_identifier  = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]
  launch_configuration = aws_launch_configuration.LC.id
  min_size             = 2
  max_size             = 4
  target_group_arns    = [aws_lb_target_group.lb_tg.arn]

  health_check_grace_period = 100

  health_check_type = "ELB"
  force_delete      = true
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