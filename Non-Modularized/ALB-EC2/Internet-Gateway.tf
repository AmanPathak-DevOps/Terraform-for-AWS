
# Creating Internet Gateway

resource "aws_internet_gateway" "Aman-IG" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Aman-IG"
  }
}