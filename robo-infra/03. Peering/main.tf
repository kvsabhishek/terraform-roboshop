resource "aws_vpc_peering_connection" "main" {
  auto_accept = "true"
  peer_vpc_id = data.aws_ssm_parameter.vpc2_id.value
  vpc_id      = data.aws_ssm_parameter.vpc1_id.value
}

resource "aws_route" "vpc1_public_peer" {
  route_table_id            = data.aws_ssm_parameter.vpc1_public_route.value
  destination_cidr_block    = data.aws_ssm_parameter.vpc2_cidr.value
  vpc_peering_connection_id = aws_vpc_peering_connection.main.id
}

resource "aws_route" "vpc1_private_peer" {
  route_table_id            = data.aws_ssm_parameter.vpc1_private_route.value
  destination_cidr_block    = data.aws_ssm_parameter.vpc2_cidr.value
  vpc_peering_connection_id = aws_vpc_peering_connection.main.id
}

resource "aws_route" "vpc2_public_peer" {
  route_table_id            = data.aws_ssm_parameter.vpc2_public_route.value
  destination_cidr_block    = data.aws_ssm_parameter.vpc1_cidr.value
  vpc_peering_connection_id = aws_vpc_peering_connection.main.id
}

resource "aws_route" "vpc2_private_peer" {
  route_table_id            = data.aws_ssm_parameter.vpc2_private_route.value
  destination_cidr_block    = data.aws_ssm_parameter.vpc1_cidr.value
  vpc_peering_connection_id = aws_vpc_peering_connection.main.id
}

resource "aws_route" "vpc2_database_peer" {
  route_table_id            = data.aws_ssm_parameter.vpc2_database_route.value
  destination_cidr_block    = data.aws_ssm_parameter.vpc1_cidr.value
  vpc_peering_connection_id = aws_vpc_peering_connection.main.id
}


