module "s3-bucket" {
  source = "../Modules/Terraform-S3Bucket"

  is_enable      = var.is_bucket_enabled
  s3bucket_count = 1
  bucket         = var.bucket_name
  force_destroy  = var.force_destroy
  environment    = var.env
}