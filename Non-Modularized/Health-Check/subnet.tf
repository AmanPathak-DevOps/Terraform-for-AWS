resource "aws_subnet" "subnet1" {
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.vpc.id

  tags = {
    Name = "Subnet-1"
  }
}

resource "aws_subnet" "subnet2" {
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.vpc.id

  tags = {
    Name = "Subnet-2"
  }
}