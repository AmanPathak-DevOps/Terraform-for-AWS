variable "access_key" {
  type = string
}


variable "secret_key" {
  type = string
}


# Providing the provider with the region and some other credentials

provider "aws" {
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

# Creating VPC with some other configures and the CIDR block will be provided by the variables.tf file and the CIDR block is 10.0.0.0/16
resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr-block
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "Aman-VPC"
  }
}


# Creating Internet Gateway and attached to the Created VPC by vpc_id
resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Aman-Gateway"
  }
}


# Creating Public Subnet and attached to the Created VPC in the availability zone us-east-1a and map_public_ip is true 
# which means that the Subnet assigned as Public IP Address, by default it is false

resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public-subnet-1a
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-Subnet-1"
  }
}


# Creating Public Subnet 2nd and attached to the Created VPC in the availability zone us-east-1b and map_public_ip is also true to make subnet as Public IP

resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public-subnet-2a
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-Subnet-2"
  }
}


# Creating Route by attached to the Created VPC and add Public route 


resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }
}


# Associate Public Subnet 1 to Public Route Table 

resource "aws_route_table_association" "route-table-association1" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.route_table.id
}

# Associate Public Subnet 2 to Public Route Table

resource "aws_route_table_association" "route-table-association2" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.route_table.id
}


# Creating Private Subnet and attached to Created VPC then, the other configurations are provided 
# such as availability zone will be us-east-1a and map_public_ip will be true which considered subnet as Private IP

resource "aws_subnet" "private-subnet-1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private-subnet-1a
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "Private-Subnet-1"
  }
}


# Creating Private Subnet and attached to Created VPC then, the other configurations are provided 
# such as availability zone will be us-east-1b and map_public_ip will be true which considered subnet as Private IP

resource "aws_subnet" "private-subnet-2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private-subnet-2a
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "Private-Subnet-2"
  }
}



# Creating Private Subnet and attached to Created VPC then, the other configurations are provided 
# such as availability zone will be us-east-1a and map_public_ip will be true which considered subnet as Private IP

resource "aws_subnet" "private-subnet-3" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private-subnet-3a
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "Private-Subnet-3"
  }
}



# Creating Private Subnet and attached to Created VPC then, the other configurations are provided 
# such as availability zone will be us-east-1b and map_public_ip will be true which considered subnet as Private IP

resource "aws_subnet" "private-subnet-4" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private-subnet-4a
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "Private-Subnet-4"
  }
}


# Creating EC2 Instance with Existing Subnet and it's attached VPC

resource "aws_instance" "EC2" {
  ami           = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public-subnet-1.id
}


