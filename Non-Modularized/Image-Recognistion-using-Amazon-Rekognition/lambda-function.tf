resource "aws_lambda_function" "image-rekognition-lambda" {
  filename         = "ImageRekognition.zip"
  function_name    = var.lambda-function-name
  role             = aws_iam_role.role-for-image-rekognition.arn
  handler          = "ImageRekognition.lambda_handler"
  runtime          = "python3.9"
  timeout          = 10
  memory_size      = 128
  source_code_hash = filebase64sha256("ImageRekognition.zip")
  environment {
    variables = {
      BUCKET_NAME     = aws_s3_bucket.image-need-to-compare.id
      SNS_TOPIC_ARN = aws_sns_topic.image-rekognition-sns.arn
    }
  }
}

resource "aws_lambda_permission" "image-rekognition-lambda-permission" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.image-rekognition-lambda.id
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${aws_s3_bucket.image-need-to-compare.id}"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.image-need-to-compare.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.image-rekognition-lambda.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = ""
    filter_suffix       = ""
  }

  depends_on = [aws_lambda_permission.image-rekognition-lambda-permission]
}