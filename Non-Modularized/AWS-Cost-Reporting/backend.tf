terraform {
  backend "s3" {
    bucket         = "my-ews-baket"
    region         = "us-east-1"
    key            = "Non-Modularized/AWS-Cost-Reporting/terraform.tfstate"
    dynamodb_table = "Lock-Files"
    encrypt        = true
  }
  required_version = ">=0.13.0"
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source  = "hashicorp/aws"
    }
  }
}
