# Creating lambda function 
resource "aws_lambda_function" "lambda-SNS" {
  filename      = "code.zip"
  function_name = "lambda-for-SNS"
  role          = aws_iam_role.iam-role.arn
  handler       = "code.lambda_handler"
  runtime       = "python3.8"
}

# Creating lambda function 
resource "aws_lambda_function" "lambda-SNS1" {
  filename      = "code.zip"
  function_name = "lambda-for-SNS1"
  role          = aws_iam_role.iam-role.arn
  handler       = "code.lambda_handler"
  runtime       = "python3.8"
}








