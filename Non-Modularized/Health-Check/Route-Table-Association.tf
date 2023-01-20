resource "aws_route_table_association" "RT-Association1" {
    subnet_id = aws_subnet.subnet1.id
    route_table_id = aws_route_table.RT.id
}

resource "aws_route_table_association" "RT-Association2" {
    subnet_id = aws_subnet.subnet2.id
    route_table_id = aws_route_table.RT
}