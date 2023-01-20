# Creating lambda function 
resource "aws_lambda_function" "lambda-2" {
  filename         = "code.zip"
  function_name    = "lambda-for-SNS"
  role             = aws_iam_role.iam-role.arn
  layers           = [aws_lambda_layer_version.layer.arn]
  handler          = "code.lambda_handler"
  runtime          = "python3.8"
  source_code_hash = filebase64sha256("code.zip")
}

# Creating lambda permission for triggering the lambda function using the S3 Upload or Delete / Left side (Add Trigger) Adding
resource "aws_lambda_permission" "test" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda-2.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${aws_s3_bucket.bucket.id}"
}



# Adding Destination to the lambda to get the mail whenever the file will be uploaded or deleted on S3 Bucket
resource "aws_lambda_function_event_invoke_config" "example" {
  function_name = aws_lambda_function.lambda-2.function_name
  destination_config {
    on_failure {
      destination = aws_sns_topic.topic-sns.arn
    }
    on_success {
      destination = aws_sns_topic.topic-sns.arn
    }
  }
}


# Adding the Lambda layer due to required the library of boto3 in the python code of lambda function 
resource "aws_lambda_layer_version" "layer" {
  s3_bucket                = aws_s3_bucket.bucket2.id
  s3_key                   = "lambda_layers.zip"
  layer_name               = "python-new-package"
  compatible_runtimes      = ["python3.8"]
  compatible_architectures = ["x86_64"]
}
