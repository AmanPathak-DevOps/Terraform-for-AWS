resource "aws_lambda_function" "lambda-fun" {
  function_name    = "s3-lambda-trigger"
  filename         = "lambda_function.zip"
  handler          = "lambda_function"
  runtime          = "python3.9"
  timeout          = 900
  source_code_hash = filebase64sha256("lambda_function.zip")
  role             = aws_iam_role.lambda-aman-role3.arn
}

