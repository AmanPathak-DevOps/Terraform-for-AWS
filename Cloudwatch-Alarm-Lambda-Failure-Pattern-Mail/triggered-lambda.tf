resource "aws_lambda_function" "triggered-lambda" {
  filename      = "index.zip"
  function_name = "triggered-lambda"
  role          = aws_iam_role.iam-role.arn
  handler       = "index.handler"
  runtime       = "nodejs14.x"
}