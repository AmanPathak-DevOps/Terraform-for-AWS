# Creating VPC with some other configures and the CIDR block will be provided by the variables.tf file and the CIDR block is 10.0.0.0/16
resource "aws_vpc" "vpc" {
  count = "${var.is_vpc_enable == 1 ? var.vpc_count : 0 }"
  cidr_block           = var.cidr_block
  instance_tenancy     = var.tenancy
  enable_dns_hostnames = var.dns_hostname

  tags = {
    Name = var.vpc_name
  }
}

# Creating Internet Gateway and attached to the Created VPC by vpc_id
resource "aws_internet_gateway" "gateway" {
  count = "${var.is_vpc_enable == 1 && var.is_gateway_enable == 1 ? var.gateway_count : 0 }"
  vpc_id = aws_vpc.vpc[count.index].id

  tags = {
    Name = var.internet_gateway_name
  }
}


# Creating Public Subnet and attached to the Created VPC in the availability zone us-east-1a and map_public_ip is true 
# which means that the Subnet assigned as Public IP Address, by default it is false

resource "aws_subnet" "public-subnet-1" {
  count = "${var.is_vpc_enable == 1 && var.is_public_subnet_enable == 1 ? var.public_subnet_count : 0 }"
  vpc_id                  = aws_vpc.vpc[count.index].id
  cidr_block              = var.subnet_cidr1
  availability_zone       = var.zone1
  map_public_ip_on_launch = var.public_ip

  tags = {
    Name = var.subnet_name1
  }
}


# Creating Private Subnet and attached to Created VPC then, the other configurations are provided 
# such as availability zone will be us-east-1a and map_public_ip will be true which considered subnet as Private IP

resource "aws_subnet" "private-subnet-1" {
  count = "${var.is_vpc_enable == 1 && var.is_private_subnet_enable == 1 ? var.private_subnet_count : 0 }"
  vpc_id                  = aws_vpc.vpc[count.index].id
  cidr_block              = var.subnet_cidr2
  availability_zone       = var.zone2
  map_public_ip_on_launch = var.private_ip

  tags = {
    Name = var.subnet_name2
  }
}


# Creating Route by attached to the Created VPC and add Public route 


resource "aws_route_table" "route_table" {
  count = "${var.is_vpc_enable == 1 && var.is_gateway_enable == 1 && var.is_rt_enable == 1 ? var.rt_count : 0 }"

  vpc_id = aws_vpc.vpc[count.index].id
  route {
    cidr_block = var.public_route
    gateway_id = aws_internet_gateway.gateway[count.index].id
  }

  tags = {
    Name = var.route_table_name
  }
}




resource "aws_route_table_association" "route-table-association1" {
  count = "${var.is_vpc_enable == 1 && var.is_public_subnet_enable == 1 && var.is_rt_enable == 1 && var.is_rta_enable == 1 ? var.rta_count : 0 }"
  subnet_id      = aws_subnet.public-subnet-1[count.index].id
  route_table_id = aws_route_table.route_table[count.index].id
}

resource "aws_security_group" "security_group" {
  count = "${var.is_vpc_enable == 1 && var.is_aws_security_group_enable == 1 ? var.security_group_count : 0 }"

  vpc_id = aws_vpc.vpc[count.index].id
  ingress {
    from_port = var.from_port1
    to_port = var.to_port1
    protocol = "tcp"
    cidr_blocks = [var.public_route]
  }

  ingress {
    from_port = var.from_port2
    to_port = var.to_port2
    protocol = "tcp"
    cidr_blocks = [var.public_route]
  }

  egress {
    from_port = 0
    to_port = 0   
    protocol = "-1"
    cidr_blocks = [var.public_route]
  }

  tags = {
    Name = var.security_group_name
  }
}