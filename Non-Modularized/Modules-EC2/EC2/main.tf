provider "aws" {
    region = "us-east-1"
}

module "Instance-Creation" {
  source = "../EC2/"
}