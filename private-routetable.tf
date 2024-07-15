
# Associate route table with DMZ subnet
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.dmz.id
  route_table_id = aws_route_table.public.id
}

# Create route table for private subnets
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-route-table"
  }
}

# Associate route table with Web App subnet
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.webapp.id
  route_table_id = aws_route_table.private.id
}

# Associate route table with Database subnet
resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.database.id
  route_table_id = aws_route_table.private.id
}