resource "aws_lambda_function" "resize-lambda-function" {
  filename         = "CreateThumbnail.zip"
  function_name    = "Image-Resizing-Lambda"
  role             = aws_iam_role.lambda-role.arn
  layers           = ["arn:aws:lambda:us-east-1:770693421928:layer:Klayers-p39-pillow:1"]
  handler          = "CreateThumbnail.handler"
  runtime          = "python3.9"
  timeout          = 60
  memory_size      = 256
  source_code_hash = base64sha256(filebase64sha256("CreateThumbnail.zip"))
  environment {
    variables = {
      Topic_Arn = aws_sns_topic.Resized-Image-SNS.arn
      S3_Bucket = aws_s3_bucket.image-resized.id
    }
  }
}

resource "aws_lambda_permission" "trigger-lambda" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.resize-lambda-function.id
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${aws_s3_bucket.image-need-to-resize.id}"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.image-need-to-resize.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.resize-lambda-function.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = ""
    filter_suffix       = ""
  }

  depends_on = [aws_lambda_permission.trigger-lambda]
}