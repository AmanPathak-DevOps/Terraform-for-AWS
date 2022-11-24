provider "aws" {
  region = "us-east-1"
}

module "EBS" {
  source = "../Resources/"
}