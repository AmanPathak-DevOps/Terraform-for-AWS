variable "is_private_key_enabled" {
    default = 1
}
variable "private_key_count" {
    default = 1
}
variable "is_key_pair_enabled" {
    default = 1
}
variable "key_pair_count" {
  default = 1
}
variable "key_name" {
    default = "instance-key"
}
variable "is_bucket_enable" {
    default = 1
}
variable "bucket_count" {
    default = 1
}
variable "bucket_name" {
    default = "bucket-para-pem"
}
variable "is_instance_enabled" {}
variable "instance_count" {}
variable "ec2_image" {}
variable "aws_instance_type" {}
variable "subnet_id" {}
variable "security_group" {}
variable "instance_name" {}