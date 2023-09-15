resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = local.list_of_public_subnets[0].id

  depends_on = [aws_eip.nat]
}
