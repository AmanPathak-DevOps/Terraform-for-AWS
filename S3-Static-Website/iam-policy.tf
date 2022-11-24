data "aws_iam_policy_document" "allow_access_from_another_account" {
    statement {
      sid = "PublicReadGetObject"
      principals {
        type        = "AWS"
        identifiers = ["*"]
      }
  
      actions = [
        "s3:GetObject",
        "s3:ListBucket",
      ]
  
      resources = [
        aws_s3_bucket.s3-bucket.arn,
        "${aws_s3_bucket.s3-bucket.arn}/*",
      ]
    }
  }
  