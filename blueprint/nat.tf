resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = local.list_of_public_subnets[0].id
  tags          = merge({ Name = "${var.project_name}-nat_gateway" }, var.common_tags)

  depends_on = [aws_eip.nat]
}
