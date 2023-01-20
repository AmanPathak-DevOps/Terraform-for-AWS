variable "is_enable" {}
variable "s3bucket_count" {}
variable "bucket" {}
variable "force_destroy" {}
variable "environment" {}

variable "bucket_acl" {
    default = "private"
}