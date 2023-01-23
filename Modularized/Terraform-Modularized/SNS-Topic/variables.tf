variable "is_enable" {}
variable "topic_name" {}


variable "is_subscription_enable" {}
variable "protocol_subscription" {}
variable "ENDPOINT" {
  default   = ""
  type      = string
  sensitive = true
}
