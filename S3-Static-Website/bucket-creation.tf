resource "aws_s3_bucket" "s3-bucket" {
  bucket        = "the-far-est-baket"
  force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
  tags = {
    Name        = "The-Web-Hostig-Bucket"
    Environment = "Dev"
  }
}

# resource "aws_s3_object" "upload-s3" {
#   for_each = fileset("./2109_the_card/", "*")
#   bucket = "the-far-est-baket"
#   acl           = "public-read"
#   key    = each.value
#   source = "./2109_the_card/${each.value}"
#   etag  = filemd5("./2109_the_card/${each.value}")
# }


resource "null_resource" "upload-to-S3" {
    provisioner "local-exec" {
      command = "aws s3 sync ${path.module}/2109_the_card s3://${aws_s3_bucket.s3-bucket.id}"
    }
}



resource "aws_s3_bucket_website_configuration" "configuration" {
    bucket = aws_s3_bucket.s3-bucket.id

     index_document {
    suffix = "index.html"
    }
}


# resource "aws_iam_policy" "iam-policy" {
#     name = "policy-bucket-s3"
#     path = "/"
#     policy = file("${path.module}/iam-policy.json")
# }


resource "aws_s3_bucket_policy" "allow_access" {
    bucket = aws_s3_bucket.s3-bucket.id

    policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

resource "aws_s3_bucket_public_access_block" "public-access" {
  bucket = aws_s3_bucket.s3-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}