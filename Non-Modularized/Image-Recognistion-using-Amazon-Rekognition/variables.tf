variable "s3-bucket-lambda-code" {
  default = "image-rekognition125865"
  type    = string
}

variable "lambda-function-name" {
  default = "Image-Rekognition-Lambda"
  type    = string
}

variable "sns-name" {
  default = "image-rekognition-SNS-Topic"
  type    = string
}

variable "mail-id" {
  default = "mailid@gmail.com"
  type    = string
}