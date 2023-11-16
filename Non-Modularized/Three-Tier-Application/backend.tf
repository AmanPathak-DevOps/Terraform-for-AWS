# To Store the Terraform state file on AWS S3 bucket and implement state locking through DynamoDB
# You can create your own bucket and DynamoDB and replace the name with your bucket and DynamoDB table
terraform {
  backend "s3" {
    bucket         = "my-ews-baket1"
    region         = "us-east-1"
    key            = "Non-Modularized/Three-Tier-Architecture/terraform.tfstate"
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