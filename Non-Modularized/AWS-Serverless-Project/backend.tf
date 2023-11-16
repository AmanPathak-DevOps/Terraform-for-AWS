terraform {
  backend "s3" {
    bucket         = "my-ews-baket1"
    region         = "us-east-1"
    key            = "Non-Modularized/AWS-Serverless-Project/terraform.tfstate"
    dynamodb_table = "Lock-Files"
    encrypt        = true
  }
  required_version = ">=0.13.0"
  required_providers {
    aws = {
      region = "us-east-1"
      version = ">= 2.7.0"
      source  = "hashicorp/aws"
    }
  }
}