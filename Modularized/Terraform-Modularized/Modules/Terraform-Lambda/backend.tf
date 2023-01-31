terraform {
  backend "s3" {
    bucket         = var.bucket-name
    region         = var.region
    key            = var.key
    dynamodb_table = var.dynamodb_table
  }
}