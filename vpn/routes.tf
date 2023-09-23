resource "aws_route_table" "vpc1_public_table" {
  vpc_id = aws_vpc.vpc1.id
}

resource "aws_route_table" "vpc2_public_table" {
  vpc_id = aws_vpc.vpc2.id
}

resource "aws_route_table" "vpc2_private_table" {
  vpc_id = aws_vpc.vpc2.id
}

resource "aws_route" "vpc1_public_route" {
  route_table_id         = aws_route_table.vpc1_public_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc1.id
}

resource "aws_route" "vpc1_peer" {
  route_table_id            = aws_route_table.vpc1_public_table.id
  destination_cidr_block    = "172.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc1_vpc2.id
}

resource "aws_route" "vpc2_public_route" {
  route_table_id         = aws_route_table.vpc2_public_table.id
  destination_cidr_block = "0.0.0.0/16"
  gateway_id             = aws_internet_gateway.vpc2.id
}

resource "aws_route" "vpc2_private_route" {
  route_table_id         = aws_route_table.vpc2_private_table.id
  destination_cidr_block = "0.0.0.0/16"
  nat_gateway_id         = aws_nat_gateway.vpc2_nat.id
}

resource "aws_route" "vpc2_peer_public" {
  route_table_id            = aws_route_table.vpc2_public_table.id
  destination_cidr_block    = "10.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc1_vpc2.id
}

resource "aws_route" "vpc2_peer_private" {
  route_table_id            = aws_route_table.vpc2_private_table.id
  destination_cidr_block    = "10.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc1_vpc2.id
}

resource "aws_route_table_association" "vpc1" {
  subnet_id      = aws_subnet.vpc1_public.id
  route_table_id = aws_route_table.vpc1_public_table.id
}

resource "aws_route_table_association" "vpc2_public" {
  subnet_id      = aws_subnet.vpc2_public.id
  route_table_id = aws_route_table.vpc2_public_table.id
}

resource "aws_route_table_association" "vpc2_private" {
  subnet_id      = aws_subnet.vpc2_private.id
  route_table_id = aws_route_table.vpc2_private_table.id
}
