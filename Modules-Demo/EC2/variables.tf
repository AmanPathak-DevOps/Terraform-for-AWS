variable "ami" {
  type    = string
  default = "ami-0f9fc25dd2506cf6d"
}
variable "key" {
  type    = string
  default = "Pathak-SahaB"
}
variable "cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}
variable "subnet_cidr_block" {
  type    = string
  default = "10.0.1.0/24"
}
