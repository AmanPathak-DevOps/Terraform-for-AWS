provider "aws" {
    region = "us-east-1"
    access_key = "AKIA2TLBO37W5UCW2SOM"
    secret_key = "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"
}



resource "aws_instance" "ec2" {
    ami = "ami-04505e74c0741db8d"
    instance_type = "t2.micro"
    tags = {
        name = "Aman-EC2"
    }
    key_name = "aman-key-pair"
}