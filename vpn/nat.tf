resource "aws_nat_gateway" "vpc2_nat" {
  allocation_id = aws_eip.vpc2_private_eip.id
  subnet_id     = aws_subnet.vpc2_private.id
}
