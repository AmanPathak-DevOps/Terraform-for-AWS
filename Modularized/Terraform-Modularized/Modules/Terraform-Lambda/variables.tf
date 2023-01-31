variable "bucket-name" {
    default = "my-ews-baket"
}
variable "region" {
    default = "us-east-1"
}
variable "key" {
    default = "terraform.tfstate"
}
variable "dynamodb_table" {
    default = "Lock-Files"
}

variable "is_enabled" {}
variable "function" {}
variable "lambda_function_name" {}
variable "lambdafile_count" {}
variable "code-for-lambda" {}
variable "runtime-for-lambda" {}
variable "handler-for-lambda" {}
variable "role-for-lambda" {}
variable "timeout-for-lambda" {}
variable "memory-size-for-lambda" {}
variable "lambda_env" {}