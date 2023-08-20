variable "vpc-name" {
  default = "Three-tier-VPC"
}

variable "ig-name" {
  default = "Three-tier-IG"
}

variable "eip1-name" {
  default = "Nat-IP1"
}

variable "eip2-name" {
  default = "NAT-IP2"
}

variable "public-subnet1" {
  default = "Web-Server1"
}

variable "public-subnet2" {
  default = "Web-Server2"
}

variable "private-subnet1" {
  default = "App-Server1"
}

variable "private-subnet2" {
  default = "App-Server2"
}

variable "private-subnet3" {
  default = "Database-Server1"
}

variable "private-subnet4" {
  default = "Database-Server2"
}

variable "ng1-name" {
  default = "NAT-GW1"
}

variable "ng2-name" {
  default = "NAT-GW2"
}

variable "public-rt1" {
  default = "Public-RT1"
}

variable "public-rt2" {
  default = "Public-RT2"
}

variable "private-rt1" {
  default = "Private-RT1"
}

variable "private-rt2" {
  default = "Private-RT2"
}

variable "private-rt3" {
  default = "Private-RT3"
}

variable "private-rt4" {
  default = "Private-RT4"
}

variable "rds-username" {
  default = "admin"
}

variable "rds-pwd" {
  default = "Aman1234"
}

variable "db-name" {
  default = "OnlineShopping"
}

variable "rds-name" {
  default = "Three-Tier-RDS"
}

variable "domain-name" {
  default = "tanishqa.tech"
}

variable "cdn-name" {
  default = "CDN-Web-ALB-Distribution"
}

variable "web_acl_name" {
  default = "MyWebACL"
}

variable "bucket-name" {
  default = "three-tier-bucket343234"
}