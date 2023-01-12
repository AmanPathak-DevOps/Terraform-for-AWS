variable "is_lambda_enabled" {
  default = "0"
}
variable "functionname" {
  default = "lambda"
}
variable "lambdafunctionname" {
  default = "for-SNS"
}
variable "lambda-runtime" {
  default = "python3.8"
}
variable "lambda-handler" {
  default = "code.lambda_handler"
}
variable "handler-code" {
  default = "code.zip"
}
variable "role-lambda" {
  default = ""
}
variable "timout-lambda" {
  default = "120"
}
variable "memory-size" {
  default = "128"
}
variable "environ" {
  default = "envir"
}
