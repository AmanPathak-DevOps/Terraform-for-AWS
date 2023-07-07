# Creating bucket to store the images and will trigger the lambda function to compare the stores images
resource "aws_s3_bucket" "image-need-to-compare" {
  bucket = var.s3-bucket-lambda-code
  lifecycle {
    prevent_destroy = false
  }

  force_destroy = true
}