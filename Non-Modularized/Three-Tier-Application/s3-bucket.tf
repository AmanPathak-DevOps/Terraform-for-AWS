# 13 Here, We are creating S3 bucket and uploading our code to the S3 bucket. The source code is in the repository itself.
resource "aws_s3_bucket" "s3-bucket" {
  bucket = var.bucket-name
}

resource "aws_s3_bucket_public_access_block" "public-access-block" {
  bucket = aws_s3_bucket.s3-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "object" {

  for_each = fileset("./aws-three-tier-web-architecture-workshop", "**/*")


  bucket = aws_s3_bucket.s3-bucket.id
  key    = "aws-three-tier-web-architecture-workshop/${each.key}"
  source = "./aws-three-tier-web-architecture-workshop/${each.key}"

  etag = filemd5("./aws-three-tier-web-architecture-workshop/${each.key}")
}