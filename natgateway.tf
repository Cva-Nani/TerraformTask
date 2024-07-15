# Create NAT Gateway


resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.dmz.id

  tags = {
    Name = "main-nat"
  }
}
