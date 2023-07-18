variable "vpc-cidr-block" {
  default = "10.0.0.0/24"
  type    = string
}

variable "vpc-name" {
  default = "vpc-web"
  type    = string
}

variable "igw-name" {
  default = "web-internet-gateway"
  type    = string
}


variable "subnet-cidr-block" {
  default = "10.0.0.0/25"
  type    = string
}

variable "public-subnet-name" {
  default = "public-subnet-web"
  type    = string
}

variable "subnet2-cidr-block" {
  default = "10.0.0.128/25"
  type    = string
}

variable "private-subnet-name" {
  default = "private-subnet-web"
}

variable "eip-name" {
  default = "eip-web"
}

variable "ngw-name" {
  default = "ngw-web"
}

variable "public-rt1-name" {
  default = "Public-Route-table"
}

variable "private-rt1-name" {
  default = "Private-Route-table"
}

variable "sg-name" {
  default = "web-sg-name"
  type    = string
}

variable "ami-id" {
  default = "ami-053b0d53c279acc90"
}

variable "key-name" {
  default = "AmanPathak"
}

variable "instance1-name" {
  default = "Web-Server"
}

variable "instance2-name" {
  default = "Database-Server"
}