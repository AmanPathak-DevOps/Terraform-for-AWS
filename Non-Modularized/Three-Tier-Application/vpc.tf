# 1 The Very first step to Create Three-Tier-Architecture is to create the Network first


# Creating VPC
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = var.vpc-name
  }
}

# Creating Internet Gateway to provide the internet 
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.ig-name
  }
}

# Creating Elastic IP1 for NAT Gateway1
resource "aws_eip" "eip1" {
  domain = "vpc"

  tags = {
    Name = var.eip1-name
  }
}

# Creating Elastic IP2 for NAT Gateway2
resource "aws_eip" "eip2" {
  domain = "vpc"

  tags = {
    Name = var.eip2-name
  }
}


# Creating Public Subnet1 for AZ1 for our Web Tier
resource "aws_subnet" "public-subnet1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = var.public-subnet1
  }
}

# Creating Public Subnet2 for AZ2 for our Web Tier
resource "aws_subnet" "public-subnet2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = var.public-subnet2
  }
}

# Creating Private Subnet1 for AZ1 for our Application Tier
resource "aws_subnet" "private-subnet1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = var.private-subnet1
  }
}

# Creating Private Subnet2 for AZ2 for our Application Tier
resource "aws_subnet" "private-subnet2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = var.private-subnet2
  }
}

# Creating Private Subnet3 for AZ1 for our Database Tier
resource "aws_subnet" "private-subnet3" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.5.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = var.private-subnet3
  }
}

# Creating Private Subnet4 for AZ2 for our Database Tier
resource "aws_subnet" "private-subnet4" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.6.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = var.private-subnet4
  }
}


# Creating NAT Gateway1 for Public Subnet1 for Web Tier
resource "aws_nat_gateway" "ng1" {
  allocation_id = aws_eip.eip1.id
  subnet_id     = aws_subnet.public-subnet1.id

  tags = {
    Name = var.ng1-name
  }
}

# Creating NAT Gateway2 for Public Subnet1 for Web Tier
resource "aws_nat_gateway" "ng2" {
  allocation_id = aws_eip.eip2.id
  subnet_id     = aws_subnet.public-subnet2.id

  tags = {
    Name = var.ng2-name
  }
}


# Creating Public Route table1 for Web Tier
resource "aws_route_table" "public-rt1" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }

  tags = {
    Name = var.public-rt1
  }
}

# Attaching Public Route table1 to Public Subnet1
resource "aws_route_table_association" "public-rt-association1" {
  subnet_id      = aws_subnet.public-subnet1.id
  route_table_id = aws_route_table.public-rt1.id
}

# Creating Public Route table2 for Web Tier
resource "aws_route_table" "public-rt2" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }

  tags = {
    Name = var.public-rt2
  }
}

# Attaching Public Route table1 to Public Subnet2
resource "aws_route_table_association" "public-rt-association2" {
  subnet_id      = aws_subnet.public-subnet2.id
  route_table_id = aws_route_table.public-rt2.id
}

# Creating Private Route table1 for App Tier
resource "aws_route_table" "private-rt1" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ng1.id
  }

  tags = {
    Name    = var.private-rt1
    Service = "App-Server1"
  }
}

# Attaching Private Route table1 to Private Subnet1
resource "aws_route_table_association" "private-rt-association1" {
  subnet_id      = aws_subnet.private-subnet1.id
  route_table_id = aws_route_table.private-rt1.id
}

# Creating Private Route table2 for App Tier
resource "aws_route_table" "private-rt2" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ng2.id
  }

  tags = {
    Name    = var.private-rt2
    Service = "App-Server2"
  }
}

# Attaching Private Route table2 to Private Subnet2
resource "aws_route_table_association" "private-rt-association2" {
  subnet_id      = aws_subnet.private-subnet2.id
  route_table_id = aws_route_table.private-rt2.id
}

# Creating Private Route table3 for Database Tier
resource "aws_route_table" "private-rt3" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ng1.id
  }

  tags = {
    Name    = var.private-rt3
    Service = "Database-Server1"
  }
}

# Attaching Private Route table3 to Private Subnet3
resource "aws_route_table_association" "private-rt-association3" {
  subnet_id      = aws_subnet.private-subnet3.id
  route_table_id = aws_route_table.private-rt3.id
}

# Creating Private Route table4 for Database Tier
resource "aws_route_table" "private-rt4" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ng2.id
  }

  tags = {
    Name    = var.private-rt4
    Service = "Database-Server2"
  }
}


# Attaching Private Route table4 to Private Subnet4
resource "aws_route_table_association" "private-rt-association4" {
  subnet_id      = aws_subnet.private-subnet4.id
  route_table_id = aws_route_table.private-rt4.id
}