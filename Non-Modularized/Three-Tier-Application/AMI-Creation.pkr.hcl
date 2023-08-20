# This will help you to create the AMI on AWS, Here we have created Ubuntu AMI
# To run this use command, 'terraform packer build AMI-Creation.pkr.hcl'
variable "ami_id" {
    type = string
    default = "ami-053b0d53c279acc90"
}

locals {
    app_name = "AMI"
}

source "amazon-ebs" "ami" {
    ami_name = "New-${local.app_name}"
    instance_type = "t2.micro"
    region = "us-east-1"
    source_ami = "${var.ami_id}"
    ssh_username = "ubuntu"

    tags = {
        Environment = "Development"
        Name = "New-${local.app_name}"
    }
}

build {
    sources = ["source.amazon-ebs.ami"]
}