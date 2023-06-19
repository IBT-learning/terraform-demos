resource "aws_route_table" "my_public_rt"{
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "dev-rt"
  }
}

resource "aws_route" "default_route" {
  route_table_id = aws_route_table.my_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.my_internet_gateway.id
}

resource "aws_route_table_association" "my_public_assoc"{
  subnet_id = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.my_public_rt.id
}
