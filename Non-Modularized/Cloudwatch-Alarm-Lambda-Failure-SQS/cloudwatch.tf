resource "aws_cloudwatch_metric_alarm" "activeMqCheck_alarm" {
  alarm_name                = "ActiveMqCheckStatusCheck"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "1"
  metric_name               = "Errors"
  namespace                 = "AWS/Lambda"
  period                    = "60"
  statistic                 = "Sum"
  threshold                 = "0"
  alarm_description         = "This metric monitors status of activeMQ"
  insufficient_data_actions = []
  actions_enabled           = "true"
  alarm_actions             = [aws_sns_topic.topic-sns.arn]

  dimensions = {
    FunctionName = "${modules.aws_lambda_function.lambda-2.function_name}"
  }
}