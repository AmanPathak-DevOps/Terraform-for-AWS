# Creating lambda function 
resource "aws_lambda_function" "lambda-2" {
  filename      = "code.zip"
  function_name = "lambda-for-SNS"
  role          = aws_iam_role.iam-role.arn
  #   layers           = [aws_lambda_layer_version.layer.arn]
  handler = "code.lambda_handler"
  runtime = "python3.8"
}

# Creating SNS Topic
resource "aws_sns_topic" "topic-sns" {
  name = "sns-topic-for-S3"
}

# Creating Subscription for the SNS Topics
resource "aws_sns_topic_subscription" "subscription" {
  topic_arn = aws_sns_topic.topic-sns.arn
  protocol  = "email"
  endpoint  = var.ENDPOINT
}


resource "aws_lambda_function_event_invoke_config" "example" {
  function_name = aws_lambda_function.lambda-2.function_name
  destination_config {
    on_failure {
      destination = aws_sns_topic.topic-sns.arn
    }
  }
}








