# Creating bucket to store the images and will trigger the lambda function to resize the store image
resource "aws_s3_bucket" "image-need-to-resize" {
  bucket = var.s3-bucket-lambda-code
  lifecycle {
    prevent_destroy = false
  }

  force_destroy = true
}
# In above bucket, upload the Image yourself after doing apply for all the services


# Creating bucekt to store the resized image after lambda function triggered
resource "aws_s3_bucket" "image-resized" {
  bucket = var.s3-bucket-dest
  lifecycle {
    prevent_destroy = false
  }

  force_destroy = true
}
