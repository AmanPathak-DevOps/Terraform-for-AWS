resource "aws_s3_bucket" "s3-bucket" {
  bucket = "s3-glue-bucket-544"
}

resource "aws_s3_object" "s3-bucket-object" {
  bucket = aws_s3_bucket.s3-bucket.id
  key    = "source/"
  source = "/dev/null"
}

resource "aws_s3_object" "s3-bucket-object2" {
  bucket = aws_s3_bucket.s3-bucket.id
  key    = "source/Mail Id - Sheet1.csv"
  source = "/home/amanpathak/Downloads/Mail Id - Sheet1.csv"
}