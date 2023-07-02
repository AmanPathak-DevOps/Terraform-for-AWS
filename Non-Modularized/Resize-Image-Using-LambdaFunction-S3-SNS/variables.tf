variable "s3-bucket-lambda-code" {
  default = "non-resized-image158658"
  type    = string
}

variable "s3-bucket-dest" {
  default = "resized-images022055553"
  type    = string
}

variable "sns-name" {
  default = "Resized-Image-SNS-Topic"
  type    = string
}

variable "mail-id" {
  default = "mailid@gmail.com"
  type    = string
}