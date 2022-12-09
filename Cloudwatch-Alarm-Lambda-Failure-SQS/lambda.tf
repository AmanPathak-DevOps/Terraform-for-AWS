# Creating lambda function 
resource "aws_lambda_function" "lambda-2" {
  filename      = "code.zip"
  function_name = "lambda-for-SNS"
  role          = aws_iam_role.iam-role.arn
  handler = "code.lambda_handler"
  runtime = "python3.8"
}



resource "aws_lambda_function_event_invoke_config" "example" {
  function_name = aws_lambda_function.lambda-2.function_name
  destination_config {
    on_failure {
      destination = aws_sqs_queue.sqs-queue.arn
    }
  }
}






