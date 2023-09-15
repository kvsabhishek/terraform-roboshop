resource "aws_route_table" "public" {
  vpc_id = aws_vpc.roboshop_vpc.id

  tags = merge({ Name = "${var.project_name}-vpc-public_route_table" }, var.common_tags)
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.roboshop_vpc.id

  tags = merge({ Name = "${var.project_name}-vpc-private_route_table" }, var.common_tags)
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route" "private" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main.id
}

resource "aws_route_table_association" "public" {
  for_each = var.public_subnet

  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  for_each = var.private_subnet

  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private.id
}
