provider "aws" {
  region = "us-east-1"
}
module "ASG" {
  source = "../Resources/"
}