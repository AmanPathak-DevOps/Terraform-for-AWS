resource "aws_lambda_function" "lambda-python2" {
  filename      = "${path.module}/code/hello.zip"
  function_name = "lambda-python2"
  role          = aws_iam_role.lambda-aman-role2.arn
  handler       = "hello.lambda_handler"
  runtime       = "python3.9"
}