resource "aws_s3_bucket" "s3-bucket" {
  bucket = "my-test-bucket-you-s-est-1"
  tags = {
    Name        = "Aman-bucket"
    Environment = "Dev"
  }
}
resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.s3-bucket.id
  acl    = "private"
}