# Creating lambda function 
resource "aws_lambda_function" "lambda-1" {
  filename      = "code.zip"
  function_name = "lambda-for-EventBridge"
  role          = aws_iam_role.iam-role.arn
  handler       = "code.lambda_handler"
  runtime       = "python3.8"
}






