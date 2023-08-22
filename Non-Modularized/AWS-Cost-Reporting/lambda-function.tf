resource "aws_lambda_function" "cost-reporting-lambda" {
  filename         = "python-code.zip"
  function_name    = "AWS-Cost-Reporting-Lambda"
  role             = aws_iam_role.iam-role.arn
  layers           = ["arn:aws:lambda:us-east-1:336392948345:layer:AWSSDKPandas-Python39:8", aws_lambda_layer_version.Datetime-layer.arn]
  handler          = "python-code.lambda_handler"
  runtime          = "python3.9"
  source_code_hash = filebase64sha256("python-code.zip")
  
  # TFSec Suggested
  tracing_config {
     mode = "Active"
   }
}

resource "aws_lambda_permission" "eventbridge-permission" {
  statement_id  = "AllowEventBridgeInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.cost-reporting-lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.eventbridge_rule.arn
}