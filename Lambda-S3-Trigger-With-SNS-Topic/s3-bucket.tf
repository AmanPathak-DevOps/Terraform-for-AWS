# Creating first bucket for where the uploading or deletion work will be performed
resource "aws_s3_bucket" "bucket" {
  bucket        = "the-best-est-unique-bucket"
  force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
  tags = {
    Name        = "My-Bucket"
    Environment = "Dev"
  }
}


# Upload a file to the first S3 Bucket
resource "aws_s3_object" "object2" {
  bucket = "the-best-est-unique-bucket"
  key    = "instant-manner-4LY4rh0NX-4-unsplash.jpg"
  source = "./instant-manner-4LY4rh0NX-4-unsplash.jpg"
}



# Creating Second Bucket to get the python packages (boto3 library)
resource "aws_s3_bucket" "bucket2" {
  bucket        = "the-best-est-unique-bucket-for-layer"
  force_destroy = true
  tags = {
    Name        = "My-Bucket2"
    Environment = "QA"
  }
}

# Uploading python packages (boto3 library) 
resource "aws_s3_object" "object" {
  bucket = "the-best-est-unique-bucket-for-layer"
  key    = "lambda_layers.zip"
  source = "./lambda_layers.zip"
}



resource "aws_s3_bucket_notification" "bucket-notification" {
  bucket = aws_s3_bucket.bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.lambda-2.arn
    events              = ["s3:ObjectCreated:*", "s3:ObjectRemoved:*"]
  }
}

