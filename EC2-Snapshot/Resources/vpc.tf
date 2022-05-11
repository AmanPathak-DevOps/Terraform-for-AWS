resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "vpc"
  }
}

resource "aws_subnet" "Public-Subnet1" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "us-east-1a"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public-Subnet1"
  }
}


resource "aws_internet_gateway" "IG" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "IG"
  }
}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.vpc.id
  route {
    gateway_id = aws_internet_gateway.IG.id
    cidr_block = "0.0.0.0/0"
  }
}

resource "aws_route_table_association" "RT-Association1" {
  subnet_id      = aws_subnet.Public-Subnet1.id
  route_table_id = aws_route_table.RT.id
}
