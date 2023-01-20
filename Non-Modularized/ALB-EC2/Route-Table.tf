
# Creating  Route Table

resource "aws_route_table" "Aman-RT" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Aman-IG.id
  }
  tags = {
    Name = "Aman-RT"
  }
}