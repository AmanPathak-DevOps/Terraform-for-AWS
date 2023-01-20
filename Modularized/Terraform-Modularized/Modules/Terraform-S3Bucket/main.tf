resource "aws_s3_bucket" "s3-bucket" {
  count = "${var.is_enable == 1 ? var.s3bucket_count : 0}"
  bucket = var.bucket
  force_destroy = var.force_destroy

  tags = {
    Environment = var.environment
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  count = 1
  bucket = aws_s3_bucket.s3-bucket[count.index].id
  acl    = var.bucket_acl
}
