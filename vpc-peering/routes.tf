resource "aws_route" "vpc1_public" {
  route_table_id         = aws_vpc.vpc1.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc1.id
}

resource "aws_route_table" "vpc2_private" {
  vpc_id = aws_vpc.vpc2.id
  tags = merge(
    var.common_tags,
    {
      Name = "PrivateSubnet"
    }
  )
}

resource "aws_route" "vpc2_public" {
  route_table_id         = aws_vpc.vpc2.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc2.id
}

resource "aws_route" "vpc2_private" {
  route_table_id         = aws_route_table.vpc2_private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.vpc2.id
}

resource "aws_route_table_association" "vpc1_public" {
  subnet_id      = aws_subnet.vpc1_public.id
  route_table_id = aws_vpc.vpc1.default_route_table_id
}

resource "aws_route_table_association" "vpc2_public" {
  subnet_id      = aws_subnet.vpc2_public.id
  route_table_id = aws_vpc.vpc2.default_route_table_id
}

resource "aws_route_table_association" "vpc2_private" {
  subnet_id      = aws_subnet.vpc2_private.id
  route_table_id = aws_route_table.vpc2_private.id
}

resource "aws_vpc_peering_connection" "vpc1_vpc2" {
  peer_vpc_id = aws_vpc.vpc2.id
  vpc_id      = aws_vpc.vpc1.id
  auto_accept = true
}

resource "aws_route" "vpc1_peer" {
  route_table_id            = aws_vpc.vpc1.default_route_table_id
  destination_cidr_block    = var.vpc2_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc1_vpc2.id
}

resource "aws_route" "vpc2_public_peer" {
  route_table_id            = aws_vpc.vpc2.default_route_table_id
  destination_cidr_block    = var.vpc1_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc1_vpc2.id
}

resource "aws_route" "vpc2_private_peer" {
  route_table_id            = aws_route_table.vpc2_private.id
  destination_cidr_block    = var.vpc1_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc1_vpc2.id
}
