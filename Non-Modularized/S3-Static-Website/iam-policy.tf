data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    sid = "PublicReadGetObject"
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.s3-bucket.arn,
      "${aws_s3_bucket.s3-bucket.arn}/*",
    ]
    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = [aws_cloudfront_distribution.cdn_website_hosting.arn]
    }
  }
}
  