resource "aws_s3_bucket_notification" "aws-lambda-trigger" {
  bucket = aws_s3_bucket.s3-bucket.id
  lambda_function {
    lambda_function_arn = aws_lambda_function.lambda-fun.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "file-prefix"
    filter_suffix       = "filter-extension"
  }
}