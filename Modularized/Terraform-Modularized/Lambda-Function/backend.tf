terraform {
  backend "s3" {
    
    bucket         = "my-ews-baket"
    region         = "us-east-1"
    key            = "terraform.tfstate"
    dynamodb_table = "Lock-Files"
  }
}