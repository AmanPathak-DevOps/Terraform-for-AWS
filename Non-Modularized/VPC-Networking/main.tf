# VPC Creation
resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc-cidr-block
  instance_tenancy = "default"
  tags = {
    Name = var.vpc-name
  }
}

# Creating Internet-Gateway and attaching to the VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.igw-name
  }
}

# Creating Public Subnet
resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet-cidr-block
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = var.public-subnet-name
  }
}

# Creating Private Subnet
resource "aws_subnet" "private-subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet2-cidr-block
  availability_zone = "us-east-1b"
  # map_public_ip_on_launch = false

  tags = {
    Name = var.private-subnet-name
  }
}

# Creating ElasticIP
resource "aws_eip" "elastic-ip" {
  domain = "vpc"

  tags = {
    Name = var.eip-name
  }
}

# Creating Natgateway, attaching the elasticIP and public subnet
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.elastic-ip.id
  subnet_id     = aws_subnet.public-subnet.id

  tags = {
    Name = var.ngw-name
  }
}

# Creating public route table and add internet gateway as destination
resource "aws_route_table" "public-rt1" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.public-rt1-name
  }
}

# Attaching public route table with public subnet 
resource "aws_route_table_association" "public-rt-association" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-rt1.id
}

# Creating private route table and add nat gateway as destination
resource "aws_route_table" "private-rt1" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = var.private-rt1-name
  }
}

# Attaching public route table with public subnet 
resource "aws_route_table_association" "private-rt-association" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private-rt1.id
}


# Creating Security group and allowing all traffic
resource "aws_security_group" "sg-all-traffic" {
  vpc_id      = aws_vpc.vpc.id
  description = "Allow All traffic"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sg-name
  }
}

# Creating Public Instance
resource "aws_instance" "public-instance" {
  ami             = var.ami-id
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.public-subnet.id
  key_name        = var.key-name
  security_groups = [aws_security_group.sg-all-traffic.id]

  tags = {
    Name = var.instance1-name
  }

  user_data = <<-EOF
  #! /bin/sh
  sudo apt-get update
  sudo apt-get install apache2 -y
  sudo systemctl enable apache2
  sudo systemctl restart apache2
  sudo apt install php libapache2-mod-php php-mysql -y
  sudo wget https://wordpress.org/latest.zip
  sudo apt-get install unzip -y
  unzip latest.zip
  sudo mv wordpress/ /var/www/html
  sudo apt install mysql-client -y
  EOF
}

# Creating Private Instance
resource "aws_instance" "database-instance" {
  ami             = var.ami-id
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.private-subnet.id
  key_name        = var.key-name
  security_groups = [aws_security_group.sg-all-traffic.id]

  tags = {
    Name = var.instance2-name
  }
}