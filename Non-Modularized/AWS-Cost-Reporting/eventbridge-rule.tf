resource "aws_cloudwatch_event_rule" "eventbridge_rule" {
  name                = "eventbridge-rule-lambda"
  description         = "EventBridge rule to trigger Lambda on the 1st of the month at 8:00 PM IST each year"
  schedule_expression = "cron(0 15 1 * ? *)"
}

resource "aws_cloudwatch_event_target" "eventbrdige_target" {
  target_id = "Lambda-function"
  rule      = aws_cloudwatch_event_rule.eventbridge_rule.name
  arn       = aws_lambda_function.cost-reporting-lambda.arn
}