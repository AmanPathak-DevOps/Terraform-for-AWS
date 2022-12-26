data "aws_cloudwatch_log_group" "default-lambda-SNS1" {
  name = "/aws/lambda/${aws_lambda_function.lambda-SNS.function_name}"
}
resource "aws_cloudwatch_log_subscription_filter" "test_lambdafunction_logfilter-lambda-SNS1" {
  name            = "test_lambdafunction_logfilter"
  log_group_name  = data.aws_cloudwatch_log_group.default-lambda-SNS1.name
  filter_pattern  = "?ERROR"
  destination_arn = aws_lambda_function.triggered-lambda.arn
  depends_on      = [aws_lambda_permission.default-lambda-SNS1]
}
resource "aws_lambda_permission" "default-lambda-SNS1" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.triggered-lambda.function_name
  principal     = "logs.us-east-1.amazonaws.com"
  source_arn    = "${data.aws_cloudwatch_log_group.default-lambda-SNS1.arn}:*"
}



data "aws_cloudwatch_log_group" "default-lambda-SNS2" {
  name = "/aws/lambda/${aws_lambda_function.lambda-SNS1.function_name}"
}
resource "aws_cloudwatch_log_subscription_filter" "test_lambdafunction_logfilter-lambda-SNS2" {
  name            = "test_lambdafunction_logfilter"
  log_group_name  = data.aws_cloudwatch_log_group.default-lambda-SNS2.name
  filter_pattern  = "?ERROR"
  destination_arn = aws_lambda_function.triggered-lambda.arn
  depends_on      = [aws_lambda_permission.default-lambda-SNS2]
}
resource "aws_lambda_permission" "default-lambda-SNS2" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.triggered-lambda.function_name
  principal     = "logs.us-east-1.amazonaws.com"
  source_arn    = "${data.aws_cloudwatch_log_group.default-lambda-SNS2.arn}:*"
}
